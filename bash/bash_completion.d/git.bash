# alias for 'git difftool'

__complete_gd()
{
    declare cur=${COMP_WORDS[COMP_CWORD]}
    declare files=( $(git status 2>/dev/null \
    	| sed -nE 's/^#?\s+modified:\s+(.+)$/\1/p') )

    COMPREPLY=( $(compgen -W "${files[*]}" -- $cur) )
}

complete -F __complete_gd gd
