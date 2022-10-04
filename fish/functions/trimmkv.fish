function trimmkv -d "Trim a segment from an MKV file"
    set -l start $argv[1] # e.g. 00:00:25.375
    set -l end $argv[2]   # e.g. 00:00:34.458
    set -l input $argv[3]
    set -l output $argv[4]
    mkvmerge --output $output --split parts:$start-$end $input
end
