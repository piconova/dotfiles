import polars as pl
import ast
from xonsh.built_ins import XSH

pl.Config.set_tbl_formatting("UTF8_FULL_CONDENSED", rounded_corners=True)
pl.Config.set_tbl_hide_dtype_separator(True)

df = None
dfs = []


class IdentifierTransformer(ast.NodeTransformer):
    def __init__(self, df: pl.DataFrame):
        self.df = df

    def visit_Name(self, node: ast.Name):
        if node.id in self.df.columns:
            node = ast.copy_location(
                ast.Call(
                    func=ast.Attribute(
                        value=ast.Name(id="pl", ctx=ast.Load()),
                        attr="col",
                        ctx=ast.Load(),
                    ),
                    args=[ast.Str(s=node.id)],
                    keywords=[],
                ),
                node,
            )

        return node

    def visit_BoolOp(self, node: ast.BoolOp):
        if isinstance(node.op, ast.And):
            return self.generic_visit(
                ast.copy_location(
                    ast.BinOp(
                        op=ast.BitAnd(), left=node.values[0], right=node.values[1]
                    ),
                    node,
                )
            )

        elif isinstance(node.op, ast.Or):
            return self.generic_visit(
                ast.copy_location(
                    ast.BinOp(
                        op=ast.BitOr(), left=node.values[0], right=node.values[1]
                    ),
                    node,
                )
            )

        return self.generic_visit(node)

    def visit_Compare(self, node: ast.Compare):
        if isinstance(node.ops[0], ast.In):
            if isinstance(node.left, ast.Str):
                col = node.comparators[0]

                return self.generic_visit(
                    ast.copy_location(
                        ast.Call(
                            func=ast.Attribute(
                                ast.Attribute(value=col, attr="str", ctx=ast.Load()),
                                attr="contains",
                                ctx=ast.Load(),
                            ),
                            args=[node.left],
                            keywords=[],
                        ),
                        node,
                    )
                )

            return self.generic_visit(
                ast.copy_location(
                    ast.Call(
                        func=ast.Attribute(
                            value=node.left, attr="is_in", ctx=ast.Load()
                        ),
                        args=node.comparators,
                        keywords=[],
                    ),
                    node,
                )
            )

        if isinstance(node.ops[0], ast.NotIn):
            if isinstance(node.left, ast.Str):
                col = node.comparators[0]

                return self.generic_visit(
                    ast.copy_location(
                        ast.UnaryOp(
                            op=ast.Invert(),
                            operand=ast.Call(
                                func=ast.Attribute(
                                    ast.Attribute(
                                        value=col, attr="str", ctx=ast.Load()
                                    ),
                                    attr="contains",
                                    ctx=ast.Load(),
                                ),
                                args=[node.left],
                                keywords=[],
                            ),
                        ),
                        node,
                    )
                )

            return self.generic_visit(
                ast.copy_location(
                    ast.UnaryOp(
                        op=ast.Invert(),
                        operand=ast.Call(
                            func=ast.Attribute(
                                value=node.left, attr="is_in", ctx=ast.Load()
                            ),
                            args=node.comparators,
                            keywords=[],
                        ),
                    ),
                    node,
                )
            )

        return self.generic_visit(node)


def __get_df() -> pl.DataFrame:
    if df is not None:
        return df

    raise Exception("No dataframe opened")


def __set_df(newDf: pl.DataFrame) -> pl.DataFrame:
    global df, dfs

    dfs.append(newDf)
    df = newDf
    return df


@aliases.register("opendf")
def __open_df(args: list[str], stdout=None):
    filename = args[0]
    columns = None
    if len(args) == 2:
        columns = [x.strip() for x in args[1].split(",")]

    global df, dfs
    df = pl.read_csv(filename, columns=columns)
    dfs = [df]

    return df


@aliases.register("undo")
def __undo(args: list[str]):
    global df, dfs
    if len(dfs) > 1:
        dfs.pop()

    df = dfs[-1]


@aliases.register("where")
def __where(args: list[str]):
    if len(args) != 1:
        raise Exception("where expects exactly one argument")

    stmt = args[0]
    df = __get_df()

    tree = ast.parse(stmt, mode="eval")
    tree = IdentifierTransformer(df).visit(tree)
    tree = ast.fix_missing_locations(tree)

    return __set_df(df.filter(eval(compile(tree, filename="", mode="eval"))))


@aliases.register("select")
def __select(args: list[str]):
    if len(args) == 0:
        raise Exception("select expects atleast one argument")

    df = __get_df()
    return __set_df(df.select([pl.col(col) for col in args]))


@aliases.register("exclude")
def __exclude(args: list[str]):
    if len(args) == 0:
        raise Exception("exclude expects atleast one argument")

    df = __get_df()
    return __set_df(df.exclude([pl.col(col) for col in args]))


@aliases.register("sort-by")
def __sort_by(args: list[str]):
    if len(args) == 0:
        raise Exception("sort-by expects atleast one argument")

    df = __get_df()
    descending = [col.endswith("dsc") or col.endswith("desc") for col in args]
    cols = [
        col.removesuffix(":asc").removesuffix(":dsc").removesuffix(":desc")
        for col in args
    ]

    return __set_df(df.sort(cols, descending=descending))


@aliases.register("csv")
def __to_csv(args: list[str]):
    df = __get_df()

    file = None
    if len(args) == 1:
        file = args[0]

    return df.write_csv(file)


@events.on_transform_command
def on_transform_polars_df(cmd: str, **kw) -> str:
    if cmd.startswith("where ") or ("| where " in cmd):
        subcommands = cmd.split("|")
        isTransformed = False
        for i in range(len(subcommands)):
            subcommand = subcommands[i].strip()
            if subcommand.startswith("where"):
                remaining = subcommand[6:].strip()
                if not (
                    (remaining.startswith("'") and remaining.endswith("'"))
                    or (remaining.startswith('"') and remaining.endswith('"'))
                ):
                    remaining = remaining.replace("'", '"')
                    subcommands[i] = "where '{}'".format(remaining)
                    isTransformed = True

        if isTransformed:
            cmd = " | ".join(subcommands)

    return cmd


#
# @events.on_postcommand
# def __clear_df(cmd: str, rtn: int, out: str or None, ts: list) -> None:
#   if "| where" in cmd:
#     global df1
#     df1 = None
