# say (macOS speech synthesizer)

command -sq say; or return

function __fish_complete_say_voices
    say -v? \
        | string replace -ar '\s+(?=[a-z]{2}_[A-Z0-9]{2}|#)' \t \
        | string split -f1 \t \
        | string match -rv ' \(.+ \(.+\)\)$' \
        | sort
end

function __fish_complete_say_devices
    say -a? | string replace -r '^\s+(\d+)\s+(.+)$' '$1\t$2\n$2\t$1'
end

function __fish_complete_say_formats
    say --file-format=? | string replace -r -f '^(\w{4})\s+(.+?) \(.*' '$1\t$2'
end

function __fish_complete_say_dataformats
    set -lx LC_ALL C
    for fmt in (__fish_complete_say_formats | string split -f1 \t)
        say --file-format=$fmt --data-format=?
    end | sort -ui | string replace -r -f '^(\w{4})\s+(.+?),.*' '$1\t$2'
end

function __fish_complete_pcm_formats
    set -l data_formats {BE,LE,}{F,I,UI}{8,16,24,32,64}
    set -l format_descs {{big,little}" endian, ",}{float,integer,unsigned int}", "{8,16,24,32,64}" samples"
    set -l x (count $data_formats)
    for i in (seq 1 $x)
        echo -s $data_formats[$i] \t "PCM: $format_descs[$i]"
    end
end

set -gx __say_interactive_colours \
    black red green yellow blue magenta cyan white

function __fish_complete_say_colours -a comp
    echo -ns $__say_interactive_colours\n | string match -e $comp
end

function __fish_complete_say_interactive
    set -l token (commandline -ct)
    set -l colour_rx (string join "|" $__say_interactive_colours)

    if string match -qr '(?<fg>.+)/(?<bg>.*)' -- $token
        # If token ends with a slash, complete with the list of colours
        set -f comps $fg/(__fish_complete_say_colours $bg)\tfg/bg
    else if string match -qr "^(?<fg>$colour_rx)" -- $token
        set -f comps $fg/(__fish_complete_say_colours $bg)\tfg/bg
    else
        set -f comps $__say_interactive_colours\tfg
        set -a comps $__say_interactive_colours/\tfg/…
        set -a comps /$__say_interactive_colours\tbg
    end

    if set -q comps[1]
        printf "%s\t\n" $comps
    end
end

set -l say_quality_opts '
    0\tlowest
    127\thighest
'

set -l say_network_opts '
    AUNetSend\tdefault
'

complete -c say -s f -l input-file -rF -d "Speak this file"
complete -c say -s v -l voice -x -a "(__fish_complete_say_voices)" -d "Use this voice"
complete -c say -s r -l rate -x -d "Speech rate in wpm"
complete -c say -s o -l output-file -rF -d "Write audio file"
complete -c say -s n -l network-send -x -a "$say_network_opts" -d "Service name and/or IP port"
complete -c say -s a -l audio-device -x -k -a "(__fish_complete_say_devices)" -d "Play using this audio device"
complete -c say -l progress -d "Display progress meter"
complete -c say -s i -d "Print while speaking"
complete -c say -l interactive -k -a "(__fish_complete_say_interactive)" -d "Print w/ markup while speaking"
complete -c say -l file-format -x -a "(__fish_complete_say_formats)" -d "Write this kind of file"
complete -c say -l data-format -x -k -a "(__fish_complete_say_dataformats; __fish_complete_pcm_formats)" -d "Audio format"
complete -c say -l channels -x -a "1 2" -d "Number of channels"
complete -c say -l bit-rate -x -d "Bit rate in bps"
complete -c say -l quality -x -a "$say_quality_opts" -d "Audio converter quality"
