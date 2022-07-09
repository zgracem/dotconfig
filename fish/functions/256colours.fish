function 256colours
    argparse 'g/grey' -- $argv
    or return

    set -l colours (seq 16 231)
    set -l width -c 192

    if set -q _flag_grey
        set colours (seq 0 15) (seq 232 255)
    end

    for n in $colours
        # set -l nnn (printf "%03d" $n)
        set -l nnn "█▓▒░ ░▒▓█"
        echo -e "\e[7;38;5;$n;48;5;16m" $nnn "\e[0m"
    end | column $width
end
