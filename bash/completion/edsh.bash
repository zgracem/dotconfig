# ------------------------------------------------------------------------------
# ~zozo/.config/bash/completion/edsh.bash
# For my "edit shell script" function
# -----------------------------------------------------------------------------

__complete_edsh()
{
    declare cur=${COMP_WORDS[COMP_CWORD]}
    declare scripts=( $(find -H "$dir_scripts" -maxdepth 2 -type f -name '*.sh' -printf '%f\n') )

    COMPREPLY=( $(compgen -W "${scripts[*]//.sh/}" -- $cur) )
}

complete -F __complete_edsh edsh
