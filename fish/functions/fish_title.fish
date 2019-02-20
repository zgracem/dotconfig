function fish_title --description 'Update the window title'
  echo "$USER@$HOSTNAME:" (pwd | string replace -r "^$HOME" "~")
end
