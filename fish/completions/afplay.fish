# afplay (macOS)

set -l afplay_quality_opts '
    0\tdefault:\ low\ quality
    1\thigh\ quality
'

complete -c afplay -s v -l volume -x -d "Set playback volume"
complete -c afplay -l leaks -d "Run leaks analysis"
complete -c afplay -s t -l time -x -d "Play for n seconds"
complete -c afplay -s r -l rate -x -d "Playback rate"
complete -c afplay -s q -l rQuality -x -a "$afplay_quality_opts" -d "Set quality for rate-scaled playback"
complete -c afplay -s d -l debug -d "Print debug output"
complete -c afplay -s h -l help -d "Print help"
