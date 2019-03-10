function rollup --description 'Create a new archive'
  set -l archive $argv[1]
  set -l contents $argv[2..-1]

  switch $archive
    case '*.tar.bz2'
      tar cjf $archive $contents
    case '*.tar.gz' '*.tgz'
      tar czf $archive $contents
    case '*.tar.xz'
      tar cf - $contents | xz -6e > $archive
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
    case '*'
      echo >&2 -s "error: don't know how to make ." \
        (string split -r -m1 . $archive)[-1]" files"
      return 1
  end
end
