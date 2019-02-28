function exls --description 'List the contents of archives'
  for archive in $argv
    switch $archive
      case '*.7z'
        7z l $archive
      case '*.jar'
        jar tf $archive
      case '*.pkg'
        pkgutil --payload-files $archive
      case '*.rar'
        unrar vb $archive; echo
      case '*.tar*'
        tar tf $archive
      case '*.tbz2'
        tar tf $archive
      case '*.tgz'
        tar tf $archive
      case '*.zip'
        zip -sf $archive
      case 'Payload'
        cpio -itv -F $archive
      case '*'
        echo >&2 -s "error: don't know how to list ." \
          (string split -r -m1 . $archive)[-1]" files"
        return 1
    end
  end
end
