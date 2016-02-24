_isFunction howto || return

__z_complete_howto()
{
    local -a wordlist=( $(__z_complete_files markdown "$dir_howto") )

    COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -F __z_complete_howto howto

### ZGM 2015-10-29
# __complete_howto()
# {
#   local -a options=( $(find -H "$dir_howto" -maxdepth 1 -type f -name '*.markdown' -printf '%f\n') )

#   COMPREPLY=( $(compgen -W "${options[*]//.markdown/}" -- "${COMP_WORDS[COMP_CWORD]}") )
# }
