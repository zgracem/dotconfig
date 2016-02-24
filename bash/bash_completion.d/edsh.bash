# for my "edit shell script" function

_isFunction edsh || return

__z_complete_edsh()
{
    local -a wordlist=( $(__z_complete_files sh "$dir_scripts" "$dir_dev") )

    COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -F __z_complete_edsh edsh

### ZGM 2015-10-29
# __complete_edsh()
# {
#     declare cur=${COMP_WORDS[COMP_CWORD]}
#     declare scripts=( $(find -H "$dir_scripts" "$dir_dev" -maxdepth 1 -type f -name '*.sh' -printf '%f\n') )

#     COMPREPLY=( $(compgen -W "${scripts[*]//.sh/}" -- $cur) )
# }
