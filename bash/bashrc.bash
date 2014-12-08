# -----------------------------------------------------------------------------
# ~zozo/.config/bash/bashrc
# executed by bash(1) for interactive shells
# -----------------------------------------------------------------------------

# abort if bash < v2.0
if ! test "$BASH_VERSINFO"; then
    return
elif ! [[ -n $PS1 && $- =~ i ]]; then
    # abort if this isn't an interactive shell
    return
fi

# -----------------------------------------------------------------------------
# shell options
# -----------------------------------------------------------------------------

set -o noclobber        # output redirection won't overwrite (override with >|filename)
set -o pipefail         # pipelines return the rightmost non-zero status, if any
set -o vi               # vi mode

shopt -s extglob        # enable extended pattern matching
shopt -s nocaseglob     # case-insensitive globbing (used in pathname expansion)
shopt -s nocasematch    # case-insensitive pattern matching in `case` and `[[`

shopt -s checkwinsize   # update LINES and COLUMNS after each command if necessary
shopt -s gnu_errfmt     # print shell error messages in the standard GNU format
shopt -u sourcepath     # [don't] use PATH to find files to source

if (( BASH_VERSINFO[0] >= 4 )); then
    if (( BASH_VERSINFO[1] >= 3 )); then
        shopt -s direxpand  # expand vars in directory names like bash 4.1 did
    fi

    if (( BASH_VERSINFO[1] >= 2 )); then
        shopt -s lastpipe   # execute a pipeline's last cmd in the current shell context
    fi

    if (( BASH_VERSINFO[1] >= 1 )); then
        export BASHOPTS     # make shopt settings available to child processes
    fi

    if (( BASH_VERSINFO[1] >= 0 )); then
        shopt -s checkjobs  # warn when exiting shell with stopped/running jobs
        shopt -s globstar   # '**' matches all directories and their files recursively
    fi
fi

if [[ $OSTYPE =~ cygwin ]]; then
    # use the short name of programs when Tab-completing
    shopt -s completion_strip_exe
fi

# completion options
shopt -s dotglob                 # include .dotfiles in filename expansion
shopt -s hostcomplete            # do hostname completion on strings containing '@'
shopt -s no_empty_cmd_completion # ignore completion attempts on empty lines

# ignore these suffixes when searching for completions
FIGNORE="DS_Store:~:.swp:Application Scripts"

# -----------------------------------------------------------------------------
# miscellany
# -----------------------------------------------------------------------------

export BLOCKSIZE=1024

# require ^D × 3 to exit
IGNOREEOF=2

# default 'rwXr-Xr-X' permissions for new files
umask 0022

# just say no to flow control
(hash stty && stty -ixon) &>/dev/null

# fix screen's stupid broken $TERMCAP -- http://robmeerman.co.uk/unix/256colours
if [[ $TERM =~ screen-256color && -n $TERMCAP ]]; then
    TERMCAP=${TERMCAP/Co#8/Co#256}
fi

# -----------------------------------------------------------------------------
# other config files
# -----------------------------------------------------------------------------

export dir_config="$HOME/.config"

export INPUTRC="${dir_config}/inputrc"
export NETHACKOPTIONS="@${dir_config}/nethackrc"
export PIP_CONFIG_FILE="${HOME}/.local/pip.conf"

_source()
{   # source files if they exist; fail silently if they don't

    local file

    for file in "$@"; do
        if [[ -r $file ]]; then
            debug_echo "# sourcing ${file}..."
            . "$file"
        fi
    done

    return 0
}

_source "$dir_config"/bash/colour.bash
_source "$dir_config"/bash/dirs.bash
_source "$dir_config"/bash/private.bash

# load shell functions
_source "$dir_config"/bash/functions.bash

# load separate function files
if [[ -d $dir_config/bash/functions.d ]]; then
    debug_echo "# sourcing $dir_config/bash/functions.d/*.bash..."
    quietly _source "$dir_config"/bash/functions.d/*.bash
fi

# source supplementary files
if [[ -d $dir_config/bash/bashrc.d ]]; then
    debug_echo "# sourcing $dir_config/bash/bashrc.d/*.bash..."
    quietly _source "$dir_config"/bash/bashrc.d/*.bash
fi

# custom bash-completion
if [[ -d $dir_config/bash/bash_completion.d ]]; then
    debug_echo "# sourcing $dir_config/bash/bash_completion.d/*.bash..."
    quietly _source "$dir_config"/bash/bash_completion.d/*.bash
fi

# -----------------------------------------------------------------------------
# machine specific files in ~/.local
# -----------------------------------------------------------------------------

_source "${dir_local}/bashrc.bash"

# load separate function files
if [[ -d $dir_local/functions.d ]]; then
    debug_echo "# sourcing $dir_local/functions.d/*.bash..."
    quietly _source "$dir_local"/functions.d/*.bash
fi

# source supplementary files
if [[ -d $dir_local/bashrc.d ]]; then
    debug_echo "# sourcing $dir_local/bashrc.d/*.bash..."
    quietly _source "$dir_local"/bashrc.d/*.bash
fi

# -----------------------------------------------------------------------------
# and finally...
# -----------------------------------------------------------------------------

# don't execute the following in screen or tmux
if [[ -z $STY && -z $TMUX ]]; then
    if [[ -x $dir_scripts/loginbanner.sh ]]; then
        "${dir_scripts}/loginbanner.sh"
    fi

    # local initialization script
    _source "${dir_local}/init.bash"
else
    return 0
fi
