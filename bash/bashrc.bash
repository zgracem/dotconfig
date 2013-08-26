# -----------------------------------------------------------------------------
# ~zozo/.config/bash/bashrc          executed by bash(1) for interactive shells
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# abort if this isn't an interactive shell
[[ $PS1 && $- =~ i ]] || {
    return
}

# just say no to flow control
hash stty 2>/dev/null && stty -ixon 2>/dev/null

_source()
{   # source file(s) if possible, exit 0 if all successfully sourced
    declare file
    for file in "$@"; do
        [[ -r $file ]] && . "$file"
    done
    return 0
}

# -----------------------------------------------------------------------------
# shell options
# -----------------------------------------------------------------------------

set +o notify           # wait till next prompt to notify of job termination
set -o noclobber        # output redirection won't overwrite (override with >|filename)
set +o pipefail         # pipelines [don't] return rightmost >0, or 0 if all exit successfully
set -o vi               # vi mode

shopt -s cdable_vars    # enable cd'ing to bash variables (cd PWD)
shopt -s cdspell        # correct minor spelling errors in the cd command
shopt -s checkhash      # check the hash table for a command before executing it
shopt -s checkwinsize   # update LINES and COLUMNS after each command if necessary
shopt -s cmdhist        # combine multiline commands into one in history
shopt -s dotglob        # include .dotfiles in filename expansion
shopt -s expand_aliases # expand aliases in non-interactive shells
shopt -s extglob        # enable extended pattern matching
shopt -s gnu_errfmt     # print shell error messages in the standard GNU format
shopt -s histappend     # append to the history file, don't overwrite it
shopt -s mailwarn       # alert on new mail
shopt -s no_empty_cmd_completion
                        # don't search PATH when completion is attempted on an empty line
shopt -s nocaseglob     # case-insensitive globbing (used in pathname expansion)
shopt -s nocasematch    # case-insensitive pattern matching in `case` and `[[`

# bash-4.0+ only
if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
    shopt -s checkjobs  # list stopped/running jobs on shell exit
    shopt -s dirspell   # correct spelling of directory names during word completion
    shopt -s globstar   # '**' matches all directories and their files recursively
fi

export BASHOPTS

# -----------------------------------------------------------------------------
# shell variables
# -----------------------------------------------------------------------------

IGNOREEOF=2                 # require ^D x 3 to exit
MAILCHECK=60                # check mail every minute
TMOUT=28800                 # logout after 8 hrs inactivity

# history
HISTFILE="$HOME/.bash_history"
HISTSIZE=4096               # remember 2^8 commands per session
HISTFILESIZE=65536          # store 2^16 lines in .bash_history
HISTCONTROL=ignoredups:ignorespace:erasedups
HISTIGNORE='-:..:[bf]g:cd:clear:exit:hist*:ls:pwd:rl:which *:wtf:* --help:\:wq'
HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="history -a; history -n"

# -----------------------------------------------------------------------------
# start agents
# -----------------------------------------------------------------------------

_source "$HOME/.ssh/agent"
_source "$HOME/.gnupg/agent"

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

[[ $timeTest ]] && return # ✁ · · · · · · · · · · · · · · · · · · · · · · · · ·

confsrc()
{
    declare what file

    for what in "$@"; do
        file="$dir_config/bash/${what%.bash}.bash"
        _source "$file"
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
    completion
    programs
    aliases
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

# this day in history...
dotfiles+=(calendar)

# source them all
confsrc ${dotfiles[@]}

# plus local .bashrc, if any
_source "$HOME/.local/bashrc.bash"

# ------------------------------------------------------------------------------
