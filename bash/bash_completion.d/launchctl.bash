return # TODO

# Based on: https://github.com/bobthecow/launchctl-completion

__z_complete_launchctl_labels()
{
    launchctl list \
    | awk 'NR>1 && $3 !~ /0x[0-9a-fA-F]+\.(anonymous|mach_init)/ {print $3}'
}

__z_complete_launchctl_started()
{
    launchctl list \
    | awk 'NR>1 && $3 !~ /0x[0-9a-fA-F]+\.(anonymous|mach_init)/ && $1 !~ /-/ {print $3}'
}

__z_complete_launchctl_stopped()
{
    launchctl list \
    | awk 'NR>1 && $3 !~ /0x[0-9a-fA-F]+\.(anonymous|mach_init)/ && $1 ~ /-/ {print $3}'
}

__z_complete_launchctl()
{
    COMPREPLY=()
    declare cur="${COMP_WORDS[COMP_CWORD]}"
    declare prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Subcommand list
    declare subcommands="load unload submit remove start stop list help"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${subcommands}" -- ${cur}) )
        return
    fi

    case "$prev" in
        remove|list)
            COMPREPLY=( $(compgen -W "$(__z_complete_launchctl_labels)" -- ${cur}) )
            return
            ;;
        start)
            COMPREPLY=( $(compgen -W "$(__z_complete_launchctl_stopped)" -- ${cur}) )
            return
            ;;
        stop)
            COMPREPLY=( $(compgen -W "$(__z_complete_launchctl_started)" -- ${cur}) )
            return
            ;;
        load|unload)
            COMPREPLY=( $(compgen -d $(pwd)) )
            return
            ;;
    esac
}

complete -F __z_complete_launchctl launchctl
