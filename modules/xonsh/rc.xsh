import sys
from xonsh.xontribs import xontribs_load

# $ALIAS_COMPLETIONS_OPTIONS_BY_DEFAULT = '1'
# $AUTO_SUGGEST_IN_COMPLETIONS = '1'
# $BASH_COMPLETIONS = '/home/yogesh/.bash-completion'
$CDPATH = '/home/yogesh'
# $CMD_COMPLETIONS_SHOW_DESC = '1'
$HISTCONTROL = 'ignoredups'
$PUSHD_SILENT = '1'
# $RAISE_SUBPROC_ERROR = '1'
# $UPDATE_COMPLETIONS_ON_KEYPRESS = '1'
$XONSH_AUTOPAIR = '1'
$XONSH_DATETIME_FORMAT = '%Y%m%d.%H%M%S'
# $XONSH_HISTORY_BACKEND = 'json'
# $XONSH_HISTORY_MATCH_ANYWHERE = '1'
$XONSH_HISTORY_SIZE = '104857600 b'

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

venvPath = "/home/yogesh/.virtualenvs/xonsh/lib/python3.10/site-packages"
$PYTHONPATH = venvPath
if venvPath not in sys.path:
  sys.path.append(venvPath)

xontribs_load(['vox', 'whole_word_jumping', 'bashisms', 'kitty', 'direnv'])
execx($(starship init xonsh))
