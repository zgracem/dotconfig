# ------------------------------------------------------------------------------
# ~zozo/.config/bash/completion/go.bash
# For my directory-bookmarking function
# -----------------------------------------------------------------------------

__complete_go()
{
    declare cur=${COMP_WORDS[COMP_CWORD]} place
    declare -a places=()

    for place in ${!dir_*} ${!go_alias[*]}; do
        places+=(${place#dir_})
    done

    COMPREPLY=( $(compgen -W "${places[*]}" -- $cur) )
}

complete -F __complete_go go
