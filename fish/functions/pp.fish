function pp -a file --description 'Pretty-print data and source code'
  switch $file
  case '*.json'
    jq . < $file
  case '*.plist'
    plutil -p $file
  case '*.fish'
    fish_indent --ansi < $file
  case '*'
    if in-path src-hilite-lesspipe.sh
      src-hilite-lesspipe.sh $file
    else
      echo >&2 -s "error: don't know how to print ." \
        (string split -r -m1 . $file)[-1]" files"
      return 1
    end
  end
end
