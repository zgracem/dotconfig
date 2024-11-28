# completion for mdls (macOS)

set -l incompatible_with_plist "__fish_seen_subcommand_from -raw -r -nullMarker -m -n -attr -name"

complete -c mdls -s n -o name -o attr -x -d 'Fetch attribute name'
complete -c mdls -s r -o raw -d 'Don\'t print attribute names'
complete -c mdls -o nullMarker -n '__fish_seen_subcommand_from -raw -r' -x -d 'String to mark null attributes'
complete -c mdls -s p -o plist -n "not $incompatible_with_plist" -rF -d 'Output in XML format to file'
complete -c mdls -s s -o sdb -d 'Implies -attr _kMDItemSDBInfoexample'
