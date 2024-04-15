# lolcat v100.0.1 <https://github.com/busyloop/lolcat>

set -l lolcat_spread '
    0.1\talmost\ vertical
    3.0\tdefault
    1000\talmost\ horizontal
'

set -l lolcat_freq '
    0.0001\talmost\ monochrome
    0.1\tdefault
'

set -l lolcat_seed '
    0\tauto
    64
    4096
'

set -l lolcat_duration '
    1\tshort
    12\tdefault
    20\tlong
'
set -l lolcat_speed '
    1.0\tslow
    20.0\tdefault
    50.0\tfast
'

complete -c lolcat -F
complete -c lolcat -s p -l spread -xa "$lolcat_spread" -d "Rainbow inclination"
complete -c lolcat -s F -l freq -xa "$lolcat_freq" -d "Rainbow frequency"
complete -c lolcat -s S -l seed -xa "$lolcat_seed" -d "Random seed"
complete -c lolcat -s a -l animate -d "Enable psychedelics"
complete -c lolcat -s d -l duration -xa "$lolcat_duration" -n "__fish_seen_argument -s a -l animate" -x -d "Duration of the animation"
complete -c lolcat -s s -l speed -xa "$lolcat_speed" -n "__fish_seen_argument -s a -l animate" -x -d "Speed of the animation"
complete -c lolcat -s i -l invert -d "Inverts foreground and background"
complete -c lolcat -s t -l truecolor -d "Enable 24-bit mode"
complete -c lolcat -s f -l force -d "Force color output"
complete -c lolcat -s v -l version -d "Print version and exit"
complete -c lolcat -s h -l help -d "Show options summary"
