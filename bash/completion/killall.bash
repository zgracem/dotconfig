# ------------------------------------------------------------------------------
# ~zozo/.config/bash/completion/killall.bash
# ------------------------------------------------------------------------------

_inPath killall || return

__complete_killall()
{
    declare processes=($(command ps -cxo command))
    declare cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${processes[*]}" -- $cur) )
}

complete -F __complete_killall killall
