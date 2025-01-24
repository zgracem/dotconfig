set -l f3probe_reset_types '
    0\tRT_MANUAL_USB
    1\tRT_USB
    2\tRT_NONE
'
complete -c f3probe -x -a "(__fish_complete_blockdevice)"
complete -c f3probe -s l -l min-memory -d 'Trade speed for less use of memory'
complete -c f3probe -s n -l destructive -d 'Do not restore blocks after probing'
complete -c f3probe -s s -l reset-type -x -a "$f3probe_reset_types" -d 'Reset method'
complete -c f3probe -s t -l time-ops -d 'Time reads, writes, and resets'
complete -c f3probe -s '?' -l help -d 'Display help'
complete -c f3probe -l usage -d 'Display usage message'
complete -c f3probe -s V -l version -d 'Display program version'
