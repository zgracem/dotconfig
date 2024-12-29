function lsar --description 'List the contents of archives'
    # brew install unar
    if command -q lsar
        command lsar $argv
        return
    end

    for archive in $argv
        switch $archive
            case '*.7z'
                7z l $archive
            case '*.jar'
                jar tf $archive
            case '*.pkg'
                pkgutil --payload-files $archive
            case '*.rar'
                unrar vb $archive
                echo
            case '*.tar' '*.tar.*' '*.tbz2' '*.tgz'
                tar tf $archive
            case '*.zip'
                zip -sf $archive
            case Payload
                cpio -itv -F $archive
            case '*'
                echo >&2 "error: don't know how to list "(path extension $archive)" files"
                return 1
        end
    end
end
