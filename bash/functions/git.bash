# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions/git.bash
# -----------------------------------------------------------------------------

ga()
{   # add files and immediately commit them
    
    git add "$@" \
        && git commit
}
