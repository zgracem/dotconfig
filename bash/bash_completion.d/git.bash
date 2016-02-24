__z_complete_src "$HOMEBREW_COMPLETION/git-completion.bash"

# alias for 'git difftool'
_isAlias gd || return

__z_complete_gd()
{
    local -a wordlist=( $(git status 2>/dev/null \
        | sed -nE 's/^#?\s+modified:\s+(.+)$/\1/p') )

    COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -F __z_complete_gd gd
