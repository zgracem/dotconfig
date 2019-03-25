function short_home --description 'Replace $HOME with ~ in a path'
  string replace -r "^$HOME(?=\$|/)" "~" $argv
end
