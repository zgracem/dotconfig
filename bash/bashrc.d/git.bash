# git

# -----------------------------------------------------------------------------
# environment variables
# -----------------------------------------------------------------------------

export GIT_AUTHOR_NAME='Zozo'
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_AUTHOR_EMAIL='zozo@inescapable.org'
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias gc='git commit'
alias gd='git difftool'

# hub -- http://hub.github.com/
_inPath hub \
    && alias git='hub '

# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

ga()
{   # add files and immediately commit them

    git add "$@" \
        && git commit
}
