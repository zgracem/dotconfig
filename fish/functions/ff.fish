function ff --description 'Finds files in PWD whose name contains a given string' -a string
  find -H "$PWD" -xtype f -iname "*$string*" -print 2>/dev/null | \
  command fgrep -i --color=auto $string
end
