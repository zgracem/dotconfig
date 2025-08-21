function clipvid -a start stop infile outfile
    if not set -q argv[1]
        echo >&2 "Usage: clipvid hh:mm:ss hh:mm:ss input.mkv output.mkv"
        return 1
    end
    mkvmerge -o $outfile --split parts:$start-$stop $infile
end
