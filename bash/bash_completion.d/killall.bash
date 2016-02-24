return ### ZGM 2015-10-29 -- I don't think this works very well yet

_inPath killall || return

__z_complete_killall()
{
    declare processes=($(command ps -cxo command))
    declare cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${processes[*]}" -- $cur) )
}

complete -o nospace -F __z_complete_killall killall
