function fd --description 'Find directories in PWD whose name contains a given string'
  find -H "$PWD" -xtype d -iname "*$argv[1]*" -print 2>/dev/null | \
  command fgrep -i --color=auto $argv[1]
end
