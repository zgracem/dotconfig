function __tiny_metadata_opts
    set -l opts copyright creation location
    __fish_complete_list , (printf "%s\t\n" $opts)
end

complete -c tinypng -s o -l overwrite -d "Replace original file"
complete -c tinypng      -l no-overwrite
complete -c tinypng -s c -l clobber -d "Overwrite original file"
complete -c tinypng      -l no-clobber
complete -c tinypng -s t -l mtime -d "Copy last-modified time"
complete -c tinypng      -l no-mtime
complete -c tinypng -s m -l metadata -x -a "(__tiny_metadata_opts)" -d "Preserve metadata"
complete -c tinypng -s a -l all-metadata -d "Copy all metadata"
complete -c tinypng -s n -l no-metadata -d "Discard all metadata"
complete -c tinypng -s W -l width -x -d "Resize to WIDTH"
complete -c tinypng -s H -l height -x -d "Resize to HEIGHT"
complete -c tinypng -s M -l method -x -a "fit scale cover thumb" -d "Use METHOD when resizing"
complete -c tinypng -s V -l version -d "Print version"
complete -c tinypng -s h -l help -d "Print help"
