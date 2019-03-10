function div --description 'Print a divider across the terminal'
  set -l line (for i in (seq 1 $COLUMNS); echo -n \u2500; end)
  if in-path lolcat
    echo $line | lolcat --spread 8
  else
    echo -s (set_color brwhite) $line (set_color normal)
  end
end
