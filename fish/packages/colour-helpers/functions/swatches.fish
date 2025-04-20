command -q magick; or return

function swatches -d "Create an image with multiple colour swatches"
    argparse 's/size=' 't/tile=' 'o/output=' -- $argv
    or return

    set -q _flag_size[1]; or set -f _flag_size 128
    if set -q _flag_tile[1]
        if string match -rq '\d+x\d+' $_flag_tile
            set -f tile_opt -tile $_flag_tile
        else
            echo >&2 "invalid tile setting: $_flag_tile"
            return 1
        end
    end
    set -q _flag_output[1]; or set -f _flag_output "swatches_"(date +%Y%m%d%H%M%S)".png"

    set -f tmpfiles
    for colour in $argv
        set -l timestamp (date +%s%N | string replace -r '0{3}$' '')
        set -l tmpout "$TMPDIR/.swatch_$timestamp.png"
        swatch --size=$_flag_size $colour $tmpout
        or return
        set -a tmpfiles $tmpout
    end

    if montage $tmpfiles -geometry "+0+0" $tile_opt $_flag_output
        rm -f $tmpfiles
        and echo $_flag_output
    end
end
