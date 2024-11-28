# comm

complete -c comm -s 1 -d "Suppress lines unique to FILE1"
complete -c comm -s 2 -d "Suppress lines unique to FILE2"
complete -c comm -s 3 -d "Suppress lines common to both files"
complete -c comm -l check-order -d "Check input is correctly sorted"
complete -c comm -l nocheck-order -d "Do not check input sorting"
complete -c comm -l output-delimiter -x -d "Separate columns with STR"
complete -c comm -l total -d "Output a summary"
complete -c comm -s z -l zero-terminated -d "Line delimiter is NUL"
complete -c comm -l help -d "Display help and exit"
complete -c comm -l version -d "Display version and exit"
