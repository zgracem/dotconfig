function figspec -d "Print a phrase in all available figlet(1) fonts"
    argparse w/width= -- $argv; or return

    set -q _flag_width[1]; or set -f _flag_width $COLUMNS
    set -q _flag_width[1]; or set -f _flag_width 80

    set -l figfonts /usr/local/opt/figlet/share/figlet/fonts/*.flf

    set -q argv[1]; or set -f argv hello world

    for fontfile in $figfonts
        set -l fontname (path change-extension '' $fontfile | path basename)
        printf "\n%-"$_flag_width"s\n\n" "== $fontname " | string replace -ar '(?<= ) ' '='
        figlet -f $fontname -w$_flag_width -c "$argv" 2>/dev/null
    end
    printf "%"$_flag_width"s\n" "END ==" | string replace -ar '(?<= |^) (?= )' '='
end
