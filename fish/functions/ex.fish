function ex --description 'Extract most kinds of archives'
  for archive in $argv
    switch $archive
      case '*.tar.bz2'
        tar xjf $archive
      case '*.bz2'
        bunzip2 $archive
      case '*.tar.gz'
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
        pkgutil --expand $archive (basename $archive '.pkg')
      case '*.rar'
        unrar x $archive
      case '*.tar'
        tar xf $archive
      case '*.tbz2'
        tar xjf $archive
      case '*.tgz'
        tar xzf $archive
      case '*.Z'
        uncompress $archive
      case '*.zip'
        unzip $archive
      case 'Payload'
        cpio -imv -F $archive
      case '*'
        echo >&2 -s "error: don't know how to extract ." \
          (string split -r -m1 . $archive)[-1]" files"
        return 1
    end
  end
end
