### ZGM TODO 2016-04-28: fix this
return 

_inPath killall || return

__z_complete_killall()
{
    declare processes=($(command ps -cxo command))
    declare cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${processes[*]}" -- $cur) )
}

complete -o nospace -F __z_complete_killall killall
