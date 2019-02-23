function __fish_right_prompt_timer -a ms
  set -l time

  if [ "$ms" -le 999 ]
    # < 1.0s
    set time $ms"ms"
  else if [ "$ms" -le 59999 ]
    # < 60.0s
    set time (math -s1 "$ms / 1000")"s"
  else if [ "$ms" -le 3599999 ]
    # < 60.0m
    set time (math -s1 "$ms / 1000 / 60")"m"
  else if [ "$ms" -le 86399999 ]
    # < 24.0h
    set time (math -s1 "$ms / 1000 / 60 / 60")"h"
  else
    # >= 24.0h
    set time (math -s2 "$ms / 1000 / 60 / 60 / 24")"d"
  end

  echo "$time "
end
