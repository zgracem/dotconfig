function fish_title --description 'Update the window title'
  echo "$USER@$hostname:" (pwd | string replace -r "^$HOME" "~")
end
