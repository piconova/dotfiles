import sys
from pathlib import Path
from xonsh.xontribs import xontribs_load
from xonsh.tools import register_custom_style, to_repr_pretty_

# =========================================================================
#                           ENVIRONMENT VARIABLES
# =========================================================================

$CDPATH = $HOME
$HISTCONTROL = 'ignoredups'
$PUSHD_SILENT = '1'
$XONSH_AUTOPAIR = '1'
$XONSH_DATETIME_FORMAT = '%Y%m%d.%H%M%S'
$XONSH_HISTORY_BACKEND = 'sqlite'
$PROMPT_TOOLKIT_COLOR_DEPTH = 'DEPTH_24_BIT'
$COMPLETIONS_DISPLAY = 'single'
$COMPLETIONS_MENU_ROWS = 5
# COMPLETIONS_CONFIRM = True
# $ALIAS_COMPLETIONS_OPTIONS_BY_DEFAULT = '1'
# $AUTO_SUGGEST_IN_COMPLETIONS = '1'
# $BASH_COMPLETIONS = '/home/yogesh/.bash-completion'
# $CMD_COMPLETIONS_SHOW_DESC = '1'
# $RAISE_SUBPROC_ERROR = '1'
# $UPDATE_COMPLETIONS_ON_KEYPRESS = '1'
# $XONSH_HISTORY_MATCH_ANYWHERE = '1'
# $XONSH_HISTORY_SIZE = '104857600 b'
# $SHELL_TYPE = 'readline'

# Colored man pages
$LESS_TERMCAP_mb = "\033[01;31m"     # begin blinking
$LESS_TERMCAP_md = "\033[01;31m"     # begin bold
$LESS_TERMCAP_me = "\033[0m"         # end mode
$LESS_TERMCAP_so = "\033[01;44;36m"  # begin standout-mode (bottom of screen)
$LESS_TERMCAP_se = "\033[0m"         # end standout-mode
$LESS_TERMCAP_us = "\033[00;36m"     # begin underline
$LESS_TERMCAP_ue = "\033[0m"         # end underline

# silence direnv output
$DIRENV_LOG_FORMAT = ""

# =========================================================================
#                                  ALIASES
# =========================================================================

aliases['xpip'] = '$HOME/.virtualenvs/xonsh/bin/pip3'
aliases['reload'] = 'source $HOME/.config/xonsh/rc.xsh'
aliases['ll'] = 'nu -c ls'

# =========================================================================
#                                  MODULES
# =========================================================================

def add_sys_path(path: str):
  if path not in sys.path:
    sys.path.append(path)

venvPath = $HOME + "/.virtualenvs/xonsh/lib/python3.10/site-packages"

add_sys_path(venvPath)
add_sys_path($HOME + '/.local/lib/python3.10/site-packages')
add_sys_path("{}".format(Path("{}/../../lib/python3.10/site-packages".format($(which python3))).resolve()))

$PYTHONPATH = venvPath

xontribs_load([
  'vox',
  'whole_word_jumping',
  'bashisms',
  'kitty',
  'direnv',
  'sh',
  'argcomplete',
])

execx($(starship init xonsh))
# exec($(carapace _carapace))

# =========================================================================
#                                   THEME
# =========================================================================

customNord = {
  "Color.INTENSE_BLACK": "#616E88",
  "Token.Comment": "#616E88",
  "Token.Keyword": 'ansiblue',
  "Token.Keyword.Pseudo": "ansicyan",
  "Token.Keyword.Type": "ansiblue",
  "Token.Operator": "ansiblue",
  "Token.Operator.Word": f"bold ansiblue",
  "Token.Name": 'ansiwhite',
  "Token.Name.Function": 'ansicyan',
  "Token.Name.Builtin": 'bold ansicyan',
  "Token.Name.Class": 'ansicyan',
  "Token.Name.Decorator": 'ansicyan',
  "Token.Name.Namespace": 'ansiwhite',
  "Token.Name.Variable": 'ansiwhite',
  "Token.Name.Variable.Magic": 'ansiwhite',
  "Token.Name.Variable.Class": 'ansiwhite',
  "Token.Name.Variable.Global": 'ansiwhite',
  "Token.String": 'ansigreen',
  "Token.String.Interpol": 'ansiyellow',
  "Token.Number": 'ansimagenta',
  # "Token.Comment.Preproc": base09,
  # "Token.Name.Exception": base0B,
  # "Token.Name.Constant": base07,
  # "Token.Name.Label": base07,
  # "Token.Name.Entity": base0C,
  # "Token.Name.Attribute": base07,
  # "Token.Name.Tag": base07,
  # "Token.String.Doc": base03,
  # "Token.String.Escape": base0D,
  # "Token.String.Regex": 'ansired',
  # "Token.String.Symbol": "ansired",
  # "Token.String.Other": "ansired",
  # "Token.Generic.Heading": f"bold {base07}",
  # "Token.Generic.Subheading": f"bold {base07}",
  # "Token.Generic.Deleted": base0B,
  # "Token.Generic.Inserted": base0E,
  # "Token.Generic.Error": base0B,
  # "Token.Generic.Emph": "italic",
  # "Token.Generic.Strong": "bold",
  # "Token.Generic.Prompt": f"bold {base03}",
  # "Token.Generic.Output": base04,
  # "Token.Generic.Traceback": base0B,
  # "Token.Error": base0B,
}

$XONSH_STYLE_OVERRIDES['completion-menu.completion'] = 'bg:ansiblack ansigreen'
$XONSH_STYLE_OVERRIDES['completion-menu.completion.current'] = 'bg:ansigreen ansiblack'

register_custom_style("customNord", customNord, base='default')
$XONSH_COLOR_STYLE="customNord"

# =========================================================================
#                                  DATA FRAME
# =========================================================================

import polars as pl
from typing import List
import ast
from xonsh.built_ins import XSH

pl.Config.set_tbl_formatting('UTF8_FULL_CONDENSED', rounded_corners=True)
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
          func = ast.Attribute(value=ast.Name(id='pl', ctx=ast.Load()), attr='col', ctx=ast.Load()),
          args = [ast.Str(s=node.id)],
          keywords = []
        ),
        node
      )

    return node

  def visit_BoolOp(self, node: ast.BoolOp):
    if isinstance(node.op, ast.And):
      return self.generic_visit(
        ast.copy_location(
          ast.BinOp(
            op = ast.BitAnd(),
            left = node.values[0],
            right = node.values[1]
          ),
          node
        )
      )

    elif isinstance(node.op, ast.Or):
      return self.generic_visit(
        ast.copy_location(
          ast.BinOp(
            op = ast.BitOr(),
            left = node.values[0],
            right = node.values[1]
          ),
          node
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
              func = ast.Attribute(ast.Attribute(value=col, attr='str', ctx=ast.Load()), attr='contains', ctx=ast.Load()),
              args = [node.left],
              keywords = []
            ),
            node,
          )
        )

      return self.generic_visit(
        ast.copy_location(
          ast.Call(
            func = ast.Attribute(value=node.left, attr='is_in', ctx=ast.Load()),
            args = node.comparators,
            keywords = []
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
              op = ast.Invert(),
              operand = ast.Call(
                func = ast.Attribute(ast.Attribute(value=col, attr='str', ctx=ast.Load()), attr='contains', ctx=ast.Load()),
                args = [node.left],
                keywords = []
              ),
            ),
            node,
          )
        )

      return self.generic_visit(
        ast.copy_location(
          ast.UnaryOp(
            op = ast.Invert(),
            operand = ast.Call(
              func = ast.Attribute(value=node.left, attr='is_in', ctx=ast.Load()),
              args = node.comparators,
              keywords = []
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
def __open_df(args: List[str], stdout=None):
  filename = args[0]
  columns = None
  if len(args) == 2:
    columns = [x.strip() for x in args[1].split(',')]

  global df, dfs
  df = pl.read_csv(filename, columns = columns)
  dfs = [df]

  XSH.shell.shell.print_color(str(df))

  return df

@aliases.register("undo")
def __undo(args: List[str]):
  global df, dfs
  if len(dfs) > 1:
    dfs.pop()

  df = dfs[-1]

@aliases.register("where")
def __where(args: List[str]):
  if len(args) != 1:
    raise Exception('where expects exactly one argument')

  stmt = args[0]
  df = __get_df()

  tree = ast.parse(stmt, mode='eval')
  tree = IdentifierTransformer(df).visit(tree)
  tree = ast.fix_missing_locations(tree)

  return __set_df(df.filter(eval(compile(tree, filename='', mode='eval'))))

@aliases.register("select")
def __select(args: List[str]):
  if len(args) == 0:
    raise Exception('select expects atleast one argument')

  df = __get_df()
  return __set_df(df.select([pl.col(col) for col in args]))

@aliases.register("exclude")
def __exclude(args: List[str]):
  if len(args) == 0:
    raise Exception('exclude expects atleast one argument')

  df = __get_df()
  return __set_df(df.exclude([pl.col(col) for col in args]))

@aliases.register("sort-by")
def __sort_by(args: List[str]):
  if len(args) == 0:
    raise Exception('sort-by expects atleast one argument')

  df = __get_df()
  descending = [col.endswith('dsc') or col.endswith("desc") for col in args]
  cols = [col.removesuffix(":asc").removesuffix(":dsc").removesuffix(":desc") for col in args]

  return __set_df(df.sort(cols, descending=descending))

@aliases.register("csv")
def __to_csv(args: List[str]):
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
      if (subcommand.startswith("where")):
        remaining = subcommand[6:].strip()
        if not ((remaining.startswith("'") and remaining.endswith("'")) or (remaining.startswith('"') and remaining.endswith('"'))):
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