# -----------------------------------------------------------------------------
# ~/.bashrc
# Executed by bash(1) on interactive shell startup
# -----------------------------------------------------------------------------

export Z_IN_BASHRC=true
chmod 400 ~/.bashrc

# Source ~/.profile, unless it's sourcing this file
if [[ -r $HOME/.profile && -z "$Z_IN_PROFILE" ]]; then
  # shellcheck source=../sh/.profile
  . "$HOME/.profile"
fi

### Abort if...
# Allow testing of array variable as a whole
# shellcheck disable=SC2128
if ! [[ $- == *i* ]]; then
  # ...this isn't an interactive shell
  return
elif shopt -q restricted_shell; then
  echo >&2 "restricted shell -- aborting .bashrc"
  return
elif [[ $HOSTNAME =~ "opalstack" && $SHLVL -lt 2 && -x ~/.local/bin/fish ]]; then
  exec ~/.local/bin/fish --login
fi

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------

set -o noclobber        # >file won't overwrite (use >|file for that)
set -o notify           # done jobs notify immediately, not on next prompt
set -o pipefail         # pipelines return rightmost non-zero status, if any
set -o vi               # vi mode

shopt -s extglob        # enable extended pattern matching
shopt -s nocaseglob     # case-insensitive globbing in pathn?m* expansion
shopt -s nocasematch    # case-insensitive patterns in `case` and `[[`
shopt -u nullglob       # (interferes with bash-completion)

shopt -s checkwinsize   # update LINES & COLUMNS after each command
shopt -s gnu_errfmt     # print shell error messages in standard GNU format
shopt -u sourcepath     # [don't] use PATH to find files to `.`

# bash-4.0+ options
# >> http://wiki.bash-hackers.org/scripting/bashchanges#shell_options

this_bash="${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}"

if [[ $this_bash -ge 42 ]]; then
  # Execute a pipeline's last cmd in the current shell context
  shopt -s lastpipe
  # Abort runaway function nesting
  FUNCNEST=128
fi

if [[ $this_bash -ge 41 ]]; then
  # Warn when exiting shell with stopped/running jobs
  shopt -s checkjobs
  # `checkjobs` is available in 4.0, but buggy:
  # >> https://lists.gnu.org/archive/html/bug-bash/2009-02/msg00176.html
fi

if [[ $this_bash -ge 40 ]]; then
  # `**` matches directories and their files recursively
  shopt -s globstar
fi

# Require ^D × (n+1) to exit
IGNOREEOF=2

# Kill ssh sessions after 8 hours' inactivity, unless tmux is active
if [[ -n $SSH_CONNECTION && -z $TMUX ]]; then
  TMOUT=$((8 * 60 * 60))
fi

# -----------------------------------------------------------------------------
# Other config files
# -----------------------------------------------------------------------------

[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"

export INPUTRC="$XDG_CONFIG_HOME/readline/.inputrc"

# Define important shell functions
# shellcheck source=./_functions.bash
. "$XDG_CONFIG_HOME/bash/_functions.bash"

# Terminal-related setup
# shellcheck source=./_terminal.bash
. "$XDG_CONFIG_HOME/bash/_terminal.bash"

# Load direction definitions ($XDG_*)
# shellcheck source=./_dirs.bash
. "$XDG_CONFIG_HOME/bash/_dirs.bash"

# Define colours (before _prompt.bash loads)
# shellcheck source=./_colour.bash
. "$XDG_CONFIG_HOME/bash/_colour.bash"

# Set fancy prompt
# shellcheck source=./_prompt.bash
. "$XDG_CONFIG_HOME/bash/_prompt.bash"

# Temporarily enable
shopt -s nullglob

# Private stuff
for file in "$HOME"/.private/bashrc.d/*.bash; do
  [[ -f $file ]] && . "$file"
done

# Lesser function files
for file in "$XDG_CONFIG_HOME"/bash/functions.d/*.bash; do
  [[ -f $file ]] && . "$file"
done

# Supplementary startup files
for file in "$XDG_CONFIG_HOME"/bash/bashrc.d/*.bash; do
  [[ -f $file ]] && . "$file"
done

# Disable after temporarily enabling above
shopt -u nullglob

# -----------------------------------------------------------------------------
# And finally...
# -----------------------------------------------------------------------------

if [[ $TERM_PROGRAM == "vscode" ]]; then
  case $PLATFORM in
  mac)
    vscode="$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/out"
    ;;
  windows)
    vscode="$(cygpath -au "$LOCALAPPDATA")/Programs/Microsoft VS Code/resources/app/out"
    ;;
  esac

  [[ -d $vscode ]] && . "$vscode/vs/workbench/contrib/terminal/browser/media/shellIntegration-bash.sh"
  unset -v vscode
fi

# Print bash version
printf 'GNU bash, version %s (%s)\n' "$BASH_VERSION" "$MACHTYPE"

unset -v file this_bash
unset -v Z_IN_BASHRC
