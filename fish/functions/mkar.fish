function mkar --description 'Create a new archive'
    argparse 'h/help' -- $argv
    or return

    set -f usage "Usage: "(status function)" archive.ext file [file ...]"
    if set -q _flag_help
        echo $usage
        return
    end

    set -l archive $argv[1]
    set -l contents $argv[2..-1]

    switch $archive
        case '*.tar.bz2'
            tar cjf $archive $contents
        case '*.tar.gz' '*.tgz'
            tar czf $archive $contents
        case '*.tar.xz'
            tar cf - $contents | xz -6e >$archive
        case '*.tar'
            tar cf $archive $contents
        case '*.7z'
            7z a -mx=9 $archive $contents
        case '*.jar'
            jar cf $archive $contents
        case '*.rar'
            rar -m5 -r $archive $contents
        case '*.zip'
            zip -9r $archive $contents
        case '*.*'
            echo >&2 "error: don't know how to make "(path extension $archive)" files"
            return 1
        case '*'
            echo >&2 "error: invalid archive name:" $archive
            echo >&2 $usage
            return 1
    end
end
