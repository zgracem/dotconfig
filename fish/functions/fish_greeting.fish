function fish_greeting --description 'Prints a greeting message on startup'
  echo -s \
    (set_color cyan)   '>' \
    (set_color green)  '<' \
    (set_color blue)   '(((' \
    (set_color brcyan) '°' \
    (set_color green)  '>' \
    (set_color normal) ' Welcome to ' \
    (set_color white)  "fish $FISH_VERSION"
end
