# completion for mdls (macOS)

# reset built-in completions
complete --erase -c mdls

complete -c mdls -s n -o attr -x -d 'Fetch attribute NAME'
complete -c mdls -s r -o raw -d 'Don\'t print attribute names'
complete -c mdls -n '__fish_seen_subcommand_from -raw -r' -o nullMarker -x -d 'String to mark null attributes'
complete -c mdls -s p -o plist -rF -d 'Output in XML format to file'
complete -c mdls -s s -o sdb -d 'Implies -attr _kMDItemSDBInfoexample'
