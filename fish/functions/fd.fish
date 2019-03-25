function fd --description 'Find directories in PWD whose name contains a given string'
  find -H "$PWD" -xtype d -iname "*$argv*" -print 2>/dev/null | \
  short_home | \
  command grep -i --color=auto "$argv"
end
