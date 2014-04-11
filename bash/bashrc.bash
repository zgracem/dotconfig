# -----------------------------------------------------------------------------
# ~zozo/.config/bash/bashrc          executed by bash(1) for interactive shells
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# abort if this isn't an interactive shell
[[ $PS1 && $- =~ i ]] || [[ $timeTest ]] || {
    return
}

# just say no to flow control
hash stty 2>/dev/null && stty -ixon 2>/dev/null

# bash version -- e.g. 32 for v3.2
bashver="${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}"

# -----------------------------------------------------------------------------
# shell options
# -----------------------------------------------------------------------------

set +o monitor          # disable job control
set +o notify           # disable instant job-termination notification (wait till next prompt)
set -o noclobber        # output redirection won't overwrite (override with >|filename)
set -o vi               # vi mode

shopt -s cdable_vars    # enable cd'ing to bash variables (cd PWD)
shopt -s cdspell        # correct minor spelling errors in the cd command
shopt -s checkhash      # check the hash table for a command before executing it
shopt -s checkwinsize   # update LINES and COLUMNS after each command if necessary
shopt -s gnu_errfmt     # print shell error messages in the standard GNU format
shopt -s mailwarn       # alert on new mail

shopt -s extglob        # enable extended pattern matching
shopt -s nocaseglob     # case-insensitive globbing (used in pathname expansion)
shopt -s nocasematch    # case-insensitive pattern matching in `case` and `[[`

if [[ $bashver -ge 43 ]]; then
    shopt -s direxpand  # expand vars in directory names like bash 4.1 did
fi

if [[ $bashver -ge 42 ]]; then
    shopt -s lastpipe   # execute a pipeline's last cmd in the current shell context
fi

if [[ $bashver -ge 41 ]]; then
    export BASHOPTS     # make shopt settings available to child processes
fi

if [[ $bashver -ge 40 ]]; then
    shopt -s autocd     # execute `/name/of/dir` as `cd /name/of/dir`
    shopt -s checkjobs  # list stopped/running jobs on shell exit
    shopt -s globstar   # '**' matches all directories and their files recursively
fi


# -----------------------------------------------------------------------------
# shell variables
# -----------------------------------------------------------------------------

IGNOREEOF=2             # require ^D x 3 to exit
MAILCHECK=300           # check mail every 5 minutes
TMOUT=28800             # logout after 8 hrs inactivity
: ${TMPDIR:=/tmp}       # if it's not already set

# `time` prints only real time elapsed and CPU usage
TIMEFORMAT=$'\nreal\t%Rs\ncpu\t%P%%'

# -----------------------------------------------------------------------------
# history
# -----------------------------------------------------------------------------

shopt -s cmdhist        # combine multiline commands into one in history
shopt -s histappend     # append to the history file, don't overwrite it
shopt -s histreedit     # re-edit failed history substitutions
shopt -s histverify     # review/change history substitutions before executing

HISTCONTROL=ignoredups:ignorespace:erasedups
HISTIGNORE='-:..:[bf]g:cd:clear:exit:hist*:ls:pwd:rl'
HISTTIMEFORMAT="%F %T "

HISTFILE="$HOME/.bash_history"

if [[ $bashver -ge 43 ]]; then
    HISTSIZE=-1         # unlimited session history
    HISTFILESIZE=-1     # unlimited $HISTFILE size
else
    HISTSIZE=4096       # remember 2^8 commands per session
    HISTFILESIZE=65536  # store 2^16 lines in $HISTFILE
fi

PROMPT_COMMAND="history -a"

# -----------------------------------------------------------------------------
# miscellany
# -----------------------------------------------------------------------------

# fix screen's stupid broken $TERMCAP -- http://robmeerman.co.uk/unix/256colours
if [[ $TERM =~ screen-256color && -n $TERMCAP ]]; then
    TERMCAP=${TERMCAP/Co#8/Co#256}
fi

# -----------------------------------------------------------------------------
# other config files
# -----------------------------------------------------------------------------

export dir_config="$HOME/.config"

_source()
{   # source files if they exist; fail silently if they don't
    
    declare file

    for file in "$@"; do
        [[ -r $file ]] && . "$file"
    done
}

confsrc()
{   # source a configuration file

    declare what file

    for what in "$@"; do
        file="$dir_config/bash/${what%.bash}.bash"
        _source "$file"
    done
}

[[ $timeTest ]] && return # ✁ · · · · · · · · · · · · · · · · · · · · · · · · ·

# base set
dotfiles=(
#   profile
#   bashrc
    paths
    functions
    places
    prefs
    programs
    aliases
    completion
    colours
    prompt
    private
)

# platform-specific
case $OSTYPE in
    darwin*)
        dotfiles+=(osx)
        ;;
    cygwin)
        dotfiles+=(cygwin)
        ;;
    linux*)
        dotfiles+=(linux)
        ;;
esac

# local .bashrc, if any
dotfiles+=(local)

# source them all
confsrc ${dotfiles[@]}

# -----------------------------------------------------------------------------
# start agents
# -----------------------------------------------------------------------------

_source "$HOME/.ssh/agent"
_source "$HOME/.gnupg/agent"

# -----------------------------------------------------------------------------
# misc.
# -----------------------------------------------------------------------------

# this day in history...
if [[ -x $dir_scripts/matins.sh ]]; then
    $dir_scripts/matins.sh
fi

# countdown (date set in private.bash)
if [[ -n $countTo ]]; then
    $dir_scripts/countdown.sh "$countTo"
else
    return 0
fi
