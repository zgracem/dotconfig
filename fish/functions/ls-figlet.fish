function ls-figlet -d "Print a phrase in all available figlet(1) fonts"
    argparse w/width= -- $argv; or return
    command -q figlet; or return 127

    set -q _flag_width[1]; or set -f _flag_width $COLUMNS
    set -q _flag_width[1]; or set -f _flag_width 80

    set -lx FIGLET_FONTDIR (path filter /usr/share/figlet $HOMEBREW_PREFIX/share/figlet/fonts)
    set -l figfonts $FIGLET_FONTDIR[1]/*.flf

    set -q argv[1]; or set -f argv hello world

    for fontfile in $figfonts
        set -l fontname (path change-extension '' $fontfile | path basename)
        printf "\n%-"$_flag_width"s\n\n" "== $fontname " | string replace -ar '(?<= ) ' '='
        figlet -f $fontname -w$_flag_width -c "$argv" 2>/dev/null
    end
    printf "%"$_flag_width"s\n" "END ==" | string replace -ar '(?<= |^) (?= )' '='
end
