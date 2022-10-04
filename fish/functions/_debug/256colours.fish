function 256colours -d "Print supported terminal colours"
    argparse -xb,g b/basic g/grey -- $argv
    or return

    set -f colours (seq 16 231)
    set -f width -c 192

    if set -q _flag_basic
        set colours (seq 0 15)
        set width[2] 64
    else if set -q _flag_grey
        set colours (seq 232 255)
        set width[2] 128
    end

    for n in $colours
        set -l nnn (printf "%03d" $n)
        # set -l nnn "█▓▒░ ░▒▓█"
        echo -e "\e[7;38;5;$n;48;5;16m" $nnn "\e[0m"
    end | column $width
end
