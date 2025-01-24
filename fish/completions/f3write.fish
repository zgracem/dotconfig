complete -c f3write -x -a "(__fish_complete_blockdevice)"
complete -c f3write -s s -l start-at -x -d 'First NUM.h2w file to be written'
complete -c f3write -s e -l end-at -x -d 'Last NUM.h2w file to be written'
complete -c f3write -s p -l show-progress -x -d 'Show progress'
complete -c f3write -s w -l max-write-rate -x -d 'Maximum write rate in KB/s'
complete -c f3write -s '?' -l help -d 'Display help'
complete -c f3write -l usage -d 'Display usage message'
complete -c f3write -s V -l version -d 'Display program version'
