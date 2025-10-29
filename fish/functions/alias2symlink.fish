function alias2symlink
    for file in $argv
        if file -p $file | string match -q '*: MacOS Alias file'
            set -l path (path resolve $file)
            and set -l dest (find-alias $path | string trim -rc/)
            and set -l tmpfile (gmktemp --suffix .alias)
            and gln -s -b -v $dest $path
            or return
        else
            echo >&2 "not an alias: $file"
            continue
        end
    end
end
