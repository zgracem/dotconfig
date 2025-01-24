set -l f3brew_reset_types '
    0\tRT_MANUAL_USB
    1\tRT_USB
    2\tRT_NONE
'

complete -c f3brew -x -a "(__fish_complete_blockdevice)"
complete -c f3brew -s h -l start-at -x -d 'Where test begins'
complete -c f3brew -s e -l end-at -x -d 'Where test ends'
complete -c f3brew -s R -l do-not-read -d 'Do not read blocks'
complete -c f3brew -s W -l do-not-write -d 'Do not write blocks'
complete -c f3brew -s s -l reset-type -x -a "$f3brew_reset_types" -d 'Reset method'
complete -c f3brew -s '?' -l help -d 'Display help'
complete -c f3brew -l usage -d 'Display usage message'
complete -c f3brew -s V -l version -d 'Display program version'
