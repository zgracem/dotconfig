complete -c f3read -x -a "(__fish_complete_blockdevice)"
complete -c f3read -s s -l start-at -x -d 'First NUM.h2w file to be read'
complete -c f3read -s e -l end-at -x -d 'Last NUM.h2w file to be read'
complete -c f3read -s p -l show-progress -x -d 'Show progress'
complete -c f3read -s r -l max-read-rate -x -d 'Maximum read rate in KB/s'
complete -c f3read -s '?' -l help -d 'Display help'
complete -c f3read -l usage -d 'Display usage message'
complete -c f3read -s V -l version -d 'Display program version'
