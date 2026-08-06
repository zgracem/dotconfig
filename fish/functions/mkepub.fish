function mkepub
    set -l dir $argv[1]
    set -l epub (path resolve $dir.epub)
    if not path is -d $dir
        echo >&2 "dir not found: $dir"
        return 1
    else if path is -f $epub
        echo >&2 "already exists: $epub"
        return 1
    end
    pushd $dir
    and zip -0X $epub mimetype
    and zip -9XDr $epub * -x "*.DS_Store" -x "*mimetype"
    and echo $epub
    popd
end
