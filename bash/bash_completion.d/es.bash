# for my "edit shell script" function

__z_complete_es()
{
    local -a wordlist=( $(__z_complete_files sh "$dir_scripts"/{,dev,util,work}) )

    COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -F __z_complete_es es
