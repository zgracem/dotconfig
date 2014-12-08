# for my directory-bookmarking function

_isFunction go || return

__complete_go()
{
    declare cur=${COMP_WORDS[COMP_CWORD]} place
    declare -a places=()
    declare alias_file="${dir_config}/bash/places/go_aliases"

    for place in ${!dir_*}; do
        places+=("${place#dir_}")
    done

    places+=($(command cut -f1 "$alias_file"))

    COMPREPLY=( $(compgen -W "${places[*]}" -- $cur) )
}

complete -F __complete_go go
