function fish_greeting --description 'Prints a greeting message on startup'
  status is-interactive; or return
  echo -s \
    (set_color cyan)   '<' \
    (set_color brcyan) '°' \
    (set_color brblue) ')))' \
    (set_color cyan)   '>' \
    (set_color green)  '<' \
    (set_color normal) ' Welcome to ' \
    (set_color white)  'fish' \
    (set_color normal) ', version ' \
    (set_color white)  "$FISH_VERSION"
  set_color normal
end
