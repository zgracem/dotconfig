# -----------------------------------------------------------------------------
# ~zozo/.config/bash/bashrc          executed by bash(1) for interactive shells
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# abort if this isn't an interactive shell
if ! [[ $PS1 && $- =~ i ]]; then
    return
fi

# who am I?
: ${USER:=$(id -un)}
: ${LOGNAME:=$USER}

# where am I?
: ${HOSTNAME:=$(hostname)}

# locale settings: Canadian English, UTF-8
LANGUAGE='en_CA:en'
LANG="$(locale -a 2>/dev/null | GREP_OPTIONS= grep -Ei 'en_CA\.utf-?8')" # "en_CA.UTF-8" or "en_CA.utf8"
LC_ALL="$LANG"
LC_CTYPE="$LANG"
LC_MESSAGES="$LANG"
TZ='America/Edmonton'

export USER LOGNAME HOSTNAME LANG LANGUAGE ${!LC_*} TZ

# some obvious terminals I use
if [[ -z $TERM_PROGRAM ]]; then
    if [[ $TERM =~ putty* ]]; then
        TERM_PROGRAM='PuTTY'
    elif [[ $TERM == xterm* && $COLUMNS -eq 80 && $LINES == 2[78] ]]; then
        TERM_PROGRAM='Prompt'
    elif [[ $TERM == vt100 && $(tty) == /dev/console ]]; then
        TERM_PROGRAM='console'
    fi
fi

export TERM_PROGRAM

# -----------------------------------------------------------------------------
# shell options
# -----------------------------------------------------------------------------

set -o monitor          # enable job control
set +o notify           # disable instant job-termination notification (wait till next prompt)
set -o noclobber        # output redirection won't overwrite (override with >|filename)
set -o pipefail         # pipelines return the rightmost non-zero status, if any
set -o vi               # vi mode

shopt -s dotglob        # include .dotfiles in filename expansion
shopt -s extglob        # enable extended pattern matching
shopt -s nocaseglob     # case-insensitive globbing (used in pathname expansion)
shopt -s nocasematch    # case-insensitive pattern matching in `case` and `[[`

shopt -s cdspell        # correct minor spelling errors in the cd command
shopt -s checkhash      # check the hash table for a command before executing it
shopt -s checkjobs      # warn when exiting shell with stopped/running jobs
shopt -s checkwinsize   # update LINES and COLUMNS after each command if necessary
shopt -s gnu_errfmt     # print shell error messages in the standard GNU format

# bash version -- e.g. 32 for v3.2
bashver="${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}"

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
    shopt -s checkjobs  # list stopped/running jobs on shell exit
    shopt -s globstar   # '**' matches all directories and their files recursively
fi

# -----------------------------------------------------------------------------
# shell variables
# -----------------------------------------------------------------------------

IGNOREEOF=2             # require ^D x 3 to exit
TMOUT=28800             # logout after 8 hrs inactivity

export TMPDIR="${TMPDIR:-/tmp}"

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
HISTIGNORE='-:--:..:[bf]g:cd:clear:exit:hist*:ls:pwd:rl'
HISTTIMEFORMAT='%F %T '

HISTFILE="$HOME/.bash_history"

if [[ $bashver -ge 43 ]]; then
    HISTSIZE=-1         # unlimited session history
    HISTFILESIZE=-1     # unlimited $HISTFILE size
else
    HISTSIZE=4096       # remember 2^8 commands per session
    HISTFILESIZE=65536  # store 2^16 lines in $HISTFILE
fi

PROMPT_COMMAND='history -a; history -n'

# -----------------------------------------------------------------------------
# mail
# -----------------------------------------------------------------------------

if [[ -r $MAIL ]]; then
    shopt -s mailwarn       # alert on new mail
    MAILCHECK=300           # check mail every 5 minutes
    MAILPATH=$MAIL?'New mail in $_'
else
    unset MAILCHECK
fi

# -----------------------------------------------------------------------------
# miscellany
# -----------------------------------------------------------------------------

# default 'rwXr-Xr-X' permissions for new files
umask 0022

# just say no to flow control
hash stty &>/dev/null \
    && stty -ixon &>/dev/null

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
    darwin*) dotfiles+=(osx) ;;
    cygwin)  dotfiles+=(cygwin) ;;
    linux*)  dotfiles+=(linux) ;;
esac

# local .bashrc, if any
dotfiles+=(local)

# source them all
for dotfile in "${dotfiles[@]}"; do
    _source "${dir_config}/bash/${dotfile}.bash"
done

unset dotfile

# -----------------------------------------------------------------------------
# start keychain
# -----------------------------------------------------------------------------

if _inPath keychain; then
    export GPG_TTY=$(tty)

    eval $(keychain --dir "${HOME}/.local/keychain" --eval --inherit any --quick --quiet id_rsa)
fi

# -----------------------------------------------------------------------------
# misc.
# -----------------------------------------------------------------------------

# don't execute the following in screen or tmux
if [[ -z $STY && -z $TMUX ]]; then
    # login banner
    if [[ -x $dir_scripts/loginbanner.sh ]]; then
        $dir_scripts/loginbanner.sh
    fi

    # local initialization script
    _source "${dir_local}/init.bash"
else
    return 0
fi
