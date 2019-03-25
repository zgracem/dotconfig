function ff --description 'Finds files in PWD whose name contains a given string'
  find -H "$PWD" -xtype f -iname "*$argv*" -print 2>/dev/null | \
  string replace -r "^$HOME(?=\$|/)" "~" | \
  command grep -i --color=auto "$argv"
end
