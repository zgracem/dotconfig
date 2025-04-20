command -q magick; or return

function swatch -d "Create a colour swatch"
    argparse 's/size=' -- $argv
    or return

    set -f colour $argv[1]
    set -f output $argv[2]
    set -q output[1]; or set -f output swatch_(string replace "#" "" $colour).png

    set -q _flag_size[1]; or set -f _flag_size 256

    string match -q "#*" $colour; or set -f colour "#$colour"

    magick -size $_flag_size"x"$_flag_size "canvas:$colour" "$output"
    or return

    return 0
end
