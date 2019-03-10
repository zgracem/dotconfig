function fish_greeting --description 'Prints a greeting message on startup'
  status is-interactive; or return
  test $FISH_VERSINFO[1] -ge 3; or return

  if in-path lolcat
    echo -n '<°)))><' | lolcat --force --spread=0.5 --seed=8
  else
    echo -ns (set_color f3a) '<' (set_color f28) '°' (set_color f66) ')))' \
      (set_color f80) '>' (set_color fa0) '<' (set_color normal)
  end

  printf ' Welcome to %bfish%b, version %b%s%b\\n' \
    (set_color brwhite) (set_color normal) \
    (set_color brwhite) $FISH_VERSION (set_color normal)
end
