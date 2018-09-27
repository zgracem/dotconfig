__z_complete_howto()
{
    local dir_howto="$HOME/txt/howto"
    local -a wordlist

    mapfile -t wordlist  < <(__z_complete_files markdown "$dir_howto")
    mapfile -t COMPREPLY < <(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}")
}

complete -F __z_complete_howto -- howto
