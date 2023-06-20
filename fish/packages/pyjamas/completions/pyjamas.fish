function __pyjamas_formats
    set --local function_file (status filename | string replace completions functions)
    set --local pj_formats (string match -rg '^\s*case ((?:\w+) ?)+$' <$function_file | path sort -u)
    echo -ns $pj_formats\t\n
end

function __pyjamas_modes
    set --local formats (__pyjamas_formats | string trim)
    string match --invert --regex '\A(\w+):(?:\1)' $formats:$formats\t
end

complete -c pyjamas -s i -l in -x -a "(__pyjamas_formats)" -d "Specify input format"
complete -c pyjamas -s o -l out -x -a "(__pyjamas_formats)" -d "Specify output format (req'd)"
complete -c pyjamas -s m -l mode -x -a "(__pyjamas_modes)" -d "Mode (INPUT:OUTPUT)"
