function fish_title --description 'Update the window title'
  echo "$USER@"(prompt_hostname)":" (pwd | string replace -r "^$HOME" "~")
end
