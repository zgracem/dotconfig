_isFunction howto || return

__z_complete_howto()
{
    local -a wordlist=( $(__z_complete_files markdown "$dir_howto") )

    COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -F __z_complete_howto howto
