function battery --description 'Display the current battery status'
  set -l battery (pmset -g batt)

  set -l percent (string match -r "(\d+%)" $battery)[1]
  set -l time (string match -r "(\d+:\d+)" $battery)[1]

  set -l icon ""

  switch (string match -r "'([^']+)'" $battery)[2]
  case "AC *"
    set icon "🔌"
  case "Battery *"
    set icon "🔋"
  case "*"
    echo $battery
    return 1
  end

  if string match -q "AC attached; not charging" $battery
    set icon "❌"
  end

  echo $icon $percent "("$time")"
end
