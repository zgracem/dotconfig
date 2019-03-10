function fish_greeting --description 'Prints a greeting message on startup'
  status is-interactive; or return
  test $FISH_VERSINFO[1] -ge 3; or return

  if in-path lolcat
    echo -s \
      (echo "<°)))><" | lolcat --force --spread=0.5 --seed 8) \
      ' Welcome to ' (set_color brwhite) 'fish' (set_color normal) \
      ', version ' (set_color brwhite) "$FISH_VERSION"
  else
    echo -s \
      (set_color 1f998f cyan)   '<' \
      (set_color 15e6df brcyan) '°' \
      (set_color 1895ff brblue) ')))' \
      (set_color 1f998f cyan)   '>' \
      (set_color 29994f green)  '<' \
      (set_color 7c8a8b normal) ' Welcome to ' \
      (set_color 9fb3b3 white)  'fish' \
      (set_color 7c8a8b normal) ', version ' \
      (set_color 9fb3b3 white)  "$FISH_VERSION"
  end
  set_color normal
end
