# Unsupported formats are not included in completions.
set -l wrestool_resource_types_numeric '
    1\tcursor
    2\tbitmap
    3\ticon
    10\trcdata
    12\tgroup_cursor
    14\tgroup_icon
    16\tversion
'
set -l wrestool_resource_types_string '
    cursor\tA\ single\ cursor\ bitmap\ image
    bitmap\tA\ bitmap\ image
    icon\tA\ single\ icon\ bitmap\ image
    rcdata\tArbitrary\ resource\ data
    group_cursor\tA\ set\ of\ cursors
    group_icon\tA\ set\ of\ icons
    version\tVersion\ information
'

complete -c wrestool -s x -l extract -d 'Extract resources'
complete -c wrestool -s l -l list -d 'List all resources'

# can have leading +/-
complete -c wrestool -s t -l type -x -a $wrestool_resource_types_numeric\n$wrestool_resource_types_string -d 'Resource type identifier'
complete -c wrestool -s n -l name -d 'Resource name identifier'

complete -c wrestool -s L -l language -d 'Resource language identifier'
complete -c wrestool -s a -l all -d 'Operate on all resources'
complete -c wrestool -s o -l output -rF -d 'Where to place extracted resources'
complete -c wrestool -s R -l raw -d 'Do not parse resource, extract raw data'
complete -c wrestool -s v -l verbose -d 'Explain what is being done'
complete -c wrestool -l help -d 'Output help and exit'
complete -c wrestool -l version -d 'Output version and exit'
