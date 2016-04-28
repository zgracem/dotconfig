# for my directory-bookmarking function

_isFunction g2 || return

__z_complete_g2()
{
    local -a wordlist=()
    local place

    # named variables
    for place in ${!dir_*}; do
        wordlist+=("${place#dir_}")
    done

    # directories under ~
    for place in "$HOME/"*/; do
        place=${place#$HOME/}   # strip home path and leading slash
        place=${place%/}        # strip trailing slash
        wordlist+=("$place")
    done

    # directory stack
    if [[ -n $DIRSTACK ]] && (( ${#DIRSTACK[@]} > 1 )); then
        wordlist+=("${DIRSTACK[@]}")
    fi

    COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -o nospace -F __z_complete_g2 g2
