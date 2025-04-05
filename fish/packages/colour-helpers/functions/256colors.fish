function 256colors -d "Print supported terminal colours"
    argparse -xb,g b/basic g/grey -- $argv
    or return

    if set -q _flag_basic
        set -f colours (seq 0 15)
        set -f width 64
    else if set -q _flag_grey
        set -f colours (seq 232 255)
        set -f width 128
    else
        set -f colours (seq 16 231)
        set -f width 192
    end

    for n in $colours
        set -l nnn (printf "%03d" $n)
        # set -l nnn "█▓▒░ ░▒▓█"
        echo -e "\e[7;38;5;$n;48;5;16m" $nnn "\e[0m"
    end | column -c $width
end
