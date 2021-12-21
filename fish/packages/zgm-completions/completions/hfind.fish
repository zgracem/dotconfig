# complete -c hfind -w "history search"

complete -c hfind -s p -l prefix -d "Match items beginning with the string"
complete -c hfind -s c -l contains -d "Match items containing the string"
complete -c hfind -s e -l exact -d "Match items identical to the string"
complete -c hfind -s t -l show-time -d "Output with timestamps"
complete -c hfind -s C -l case-sensitive -d "Match items in a case-sensitive manner"
complete -c hfind -s n -l max -d "Limit output to the first 'n' matches" -x
complete -c hfind -s z -l null -d "Terminate entries with NUL character"
complete -c hfind -s R -l reverse -d "Output the oldest results first" -x

complete -c hfind -s t -l show-time --erase
