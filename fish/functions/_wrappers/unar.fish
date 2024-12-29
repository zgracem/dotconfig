function unar --description 'Extract most kinds of archives'
    # brew install unar
    if command -q unar
        command unar $argv
        return
    end

    for archive in $argv
        switch $archive
            case '*.tar.bz2' '*.tbz2'
                tar xjf $archive
            case '*.bz2'
                bunzip2 $archive
            case '*.tar.gz' '*.tgz'
                tar xzf $archive
            case '*.gz'
                gunzip $archive
            case '*.tar.xz'
                unxz -ck $archive | tar xf -
            case '*.xz'
                unxz -k $archive
            case '*.7z'
                7z x $archive
            case '*.jar'
                jar xf $archive
            case '*.pkg'
                pkgutil --expand $archive (path change-extension $archive "")/
            case '*.rar'
                unrar x $archive
            case '*.tar'
                tar xf $archive
            case '*.Z'
                uncompress $archive
            case '*.zip'
                unzip $archive
            case Payload
                cpio -imv -F $archive
            case '*'
                echo >&2 "error: don't know how to extract "(path extension $archive)" files"
                return 1
        end
    end
end
