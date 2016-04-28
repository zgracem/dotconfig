# for my "edit shell script" function

_isFunction edsh || return

__z_complete_edsh()
{
    local -a wordlist=( $(__z_complete_files sh "$dir_scripts" "$dir_dev") )

    COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -F __z_complete_edsh edsh
