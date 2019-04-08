function pp -a file --description 'Pretty-print data and source code'
  switch "$file"
  case ''
    echo >&2 'Usage: pp <file>'
    return 1
  case '*.json'
    jq . < $file
  case '*.plist'
    plutil -p $file
  case '*.fish'
    fish_indent --ansi < $file
  case '*.csv'
    # http://stackoverflow.com/questions/1875305/command-line-csv-viewer
    sed 's/,,/, ,/g;s/,,/, ,/g' $file | column -s, -t
  case '*'
    if in-path bat
      bat --plain --paging=never $file
    else if in-path src-hilite-lesspipe.sh
      src-hilite-lesspipe.sh $file
    else
      set -l ext (string split -r -m1 . $file)[-1]
      echo >&2 "error: don't know how to print .$ext files"
      return 1
    end
  end
end
