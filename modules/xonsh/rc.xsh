# =========================================================================
#                           ENVIRONMENT VARIABLES
# =========================================================================
$HISTCONTROL = 'ignoredups'
$PUSHD_SILENT = '1'
$XONSH_AUTOPAIR = '1'
$XONSH_DATETIME_FORMAT = '%Y%m%d.%H%M%S'
$XONSH_HISTORY_BACKEND = 'sqlite'
$PROMPT_TOOLKIT_COLOR_DEPTH = 'DEPTH_24_BIT'
$COMPLETIONS_DISPLAY = 'single'
$COMPLETIONS_MENU_ROWS = 5

# silence direnv output
$DIRENV_LOG_FORMAT = ""

# =========================================================================
#                                  ALIASES
# =========================================================================

aliases['xpip'] = '$HOME/.virtualenvs/xonsh/bin/pip3'
aliases['reload'] = 'source $HOME/.config/xonsh/rc.xsh'
aliases['vim'] = 'nvim'
aliases['ll'] = 'nu -c ls'

# =========================================================================
#                                  MODULES
# =========================================================================
import sys
from pathlib import Path
from xonsh.xontribs import xontribs_load

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
  'kitty',
  'direnv',
  'sh',
  'argcomplete',
])

execx($(starship init xonsh))

from dataframe import *

# =========================================================================
#                                   THEME
# =========================================================================
from xonsh.tools import register_custom_style

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
