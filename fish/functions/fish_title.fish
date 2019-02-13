function fish_title --description 'Update the window title'
  echo "$USER@$short_hostname:" (pwd | string replace -r "^$HOME" "~")
end
