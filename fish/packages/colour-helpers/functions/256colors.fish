function 256colors -d "Print supported terminal colours"
    argparse -xb,g b/basic g/grey -- $argv
    or return

    if set -q _flag_basic
        set -f colours (seq 0 15)
        set -f width (math "2 * 32")
    else if set -q _flag_grey
        set -f colours (seq 232 255)
        set -f width (math "4 * 32")
    else
        set -f colours (seq 16 231)
        set -f width (math "6 * 32")
    end

    for n in $colours
        printf "\e[38;5;16;48;5;%dm %03d \e[0m\n" $n $n
    end | column -c $width
end
