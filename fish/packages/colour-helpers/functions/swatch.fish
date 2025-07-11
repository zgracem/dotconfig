command -q magick; or return

function swatch -d "Create a colour swatch"
    argparse 's/size=' 'v/verbose' -- $argv
    or return

    set -f colour $argv[1] # must be in `rrggbb` or `#rrggbb` format
    if not string match -irq '^#?[0-9a-f]{6}([0-9a-f]{2})?$' $colour
        echo >&2 "invalid colour: $colour"
        return 1
    end

    set -f output $argv[2]
    set -q output[1]; or set -f output swatch_(string replace "#" "" $colour).png

    set -q _flag_size[1]; or set -f _flag_size 256

    string match -q "#*" $colour; or set -f colour "#$colour"

    magick -size $_flag_size"x"$_flag_size "canvas:$colour" "$output"
    or return

    set -q _flag_verbose; and echo $output

    return 0
end
