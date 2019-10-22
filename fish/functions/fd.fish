function fd --description 'Find directories in PWD whose name contains a given string' -a string
  find -H "$PWD" -xtype d -iname "*$string*" -print 2>/dev/null | \
  command fgrep -i --color=auto $string
end
