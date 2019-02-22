function __fish_right_prompt_timer
	set ms $argv[1]

  if test "$ms" -le 499           # < 0.5s
    set time $ms"ms"
  else if test "$ms" -le 59999    # < 60.0s
    set time (math -s 1 "$ms / 1000")"s"
  else if test "$ms" -le 3599999  # < 60.0m
    set time (math -s 1 "$ms / 1000 / 60")"m"
  else if test "$ms" -le 86399999 # < 24.0h
    set time (math -s 1 "$ms / 1000 / 60 / 60")"h"
  else                            # >= 24.0h
    set time (math -s 2 "$ms / 1000 / 60 / 60 / 24")"d"
  end

  echo "$time "
end
