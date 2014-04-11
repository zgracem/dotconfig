# -----------------------------------------------------------------------------
# ~zozo/.config/bash/profile               executed by bash(1) for login shells
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# who am I?
: ${USER:=$(id -un)}
: ${LOGNAME:=$USER}

# where am I?
: ${HOSTNAME:=$(hostname)}

# locale settings: Canadian English, UTF-8
LANGUAGE="en_CA:en"
LANG="$(locale -a 2>/dev/null | GREP_OPTIONS= grep -Ei 'en_CA\.utf-?8')" # "en_CA.UTF-8" or "en_CA.utf8"
LC_ALL="$LANG"
TZ="America/Edmonton"

export USER LOGNAME HOSTNAME LANG LANGUAGE LC_ALL TZ

# default 'rwX------' permissions for new files
umask 0077

# ------------------------------------------------------------------------------
# shell options
# ------------------------------------------------------------------------------

set -o noclobber        # output redirection won't overwrite (override with >|filename)
shopt -s dotglob        # include .dotfiles in filename expansion
shopt -s extglob        # enable extended pattern matching
shopt -s nocaseglob     # case-insensitive globbing (used in pathname expansion)
shopt -s nocasematch    # case-insensitive pattern matching in `case` and `[[`

# bash-4.0+ only
if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
    shopt -s globstar   # '**' matches all directories and their files recursively
fi

# ------------------------------------------------------------------------------
# other settings
# ------------------------------------------------------------------------------

export BLOCKSIZE=1024
export COPYFILE_DISABLE=true     # exclude ._resourceforks from tarballs
export COMP_TAR_INTERNAL_PATHS=1 # avoid flattening contents of tar files

# export RSYNC_RSH="$(type -P ssh) -aq -oBatchmode=yes"

# -----------------------------------------------------------------------------
# source .bashrc
# -----------------------------------------------------------------------------

[[ $timeTest ]] && return # ✁ · · · · · · · · · · · · · · · · · · · · · · · · ·

[[ -r $HOME/.config/bash/bashrc.bash ]] &&
    . $HOME/.config/bash/bashrc.bash
