# Based on `256colors2.pl` by Todd Larason
# https://www.robmeerman.co.uk/_media/unix/256colors2.pl

function __256colours_system
    argparse --ignore-unknown N/numbers -- $argv
    or return

    set -l long_format "\e[48;5;%dm%'3d"
    set -l short_format "\e[48;5;%dm  "

    echo "System colours:"
    if set -q _flag_numbers
        for n in (seq 0 7)
            printf $long_format $n $n
        end
    else
        for n in (seq 0 7)
            printf $short_format $n
        end
    end
    echo -ne "\e[0m\n"
    if set -q _flag_numbers
        for n in (seq 8 15)
            printf $long_format $n $n
        end
    else
        for n in (seq 8 15)
            printf $short_format $n
        end
    end
    echo -ne "\e[0m\n"
end

function __256colours_cube
    argparse --ignore-unknown N/numbers -- $argv
    or return

    echo "Colour cube, 6×6×6:"
    for g in (seq 0 5)
        for r in (seq 0 5)
            for b in (seq 0 5)
                set -l n (math "16 + ($r * 36) + ($g * 6) + $b")
                if set -q _flag_numbers
                    printf "\e[48;5;%dm%'3d" $n $n
                else
                    printf "\e[48;5;%dm  " $n
                end
            end
            echo -ne "\e[0m  "
        end
        echo -ne "\n"
    end
end

function __256colours_grey
    argparse --ignore-unknown N/numbers -- $argv
    or return

    echo "Greyscale ramp:"
    if set -q _flag_numbers
        for n in (seq 232 255)
            printf "\e[48;5;%dm%03d" $n $n
        end
    else
        for n in (seq 232 255)
            printf "\e[48;5;%dm  " $n
        end
    end
    echo -ne "\e[0m\n"
end

function 256colours
    argparse s/system c/cube g/grey N/numbers -- $argv
    or return

    if string match -q xx x"$_flag_system$_flag_cube$_flag_grey"x
        set -f _flag_system 1
        set -f _flag_cube 1
        set -f _flag_grey 1
    end
    set -q _flag_system; and __256colours_system $_flag_numbers
    set -q _flag_cube; and __256colours_cube $_flag_numbers
    set -q _flag_grey; and __256colours_grey $_flag_numbers

    return 0
end
