function __pyjamas_formats
    pyjamas --list
end

function __pyjamas_modes
    set --local formats (__pyjamas_formats | string trim)
    string match --invert --regex '\A(\w+):(?:\1)' $formats:$formats\t
end

complete -c pyjamas -s i -l in -x -a "(__pyjamas_formats)" -d "Specify input format"
complete -c pyjamas -s o -l out -x -a "(__pyjamas_formats)" -d "Specify output format"
complete -c pyjamas -s m -l mode -x -a "(__pyjamas_modes)" -d "Specify INPUT:OUTPUT"
complete -c pyjamas -s p -l pager -x -a "(__fish_complete_subcommand)" -d "Send output to PAGER"
complete -c pyjamas -s l -l list -d "List supported formats"
complete -c pyjamas -s I -l install-gems -d "Install required gems"
complete -c pyjamas -s d -l debug -d "Debug mode"
complete -c pyjamas -s h -l help -d "Display help"
