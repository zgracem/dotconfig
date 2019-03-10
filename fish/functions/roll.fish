function roll --description 'Roll some dice'
  set -l regex '\b(\d+)?d?(\d+)\b'
  set -l totals

  set -q argv[1]; or set -l argv[1] '1d20'

  function sum; echo $argv[1] "=" (math $argv[1]); end

  for arg in $argv
    set -l die
    set -l times
    set -l rematch (string match -ar $regex $arg)

    switch (count $rematch)
    case 3
      set die $rematch[3]
      set times $rematch[2]
    case 2
      set die $rematch[2]
      set times 1
    case '*'
      echo >&2 "error: don't know how to roll “$arg”" # "(got" (count $rematch) "matches, expected 2 or 3)"
      return 1
    end

    set -l results
    for i in (seq 1 $times)
      set results[$i] (random 1 $die)
    end

    set -l total (string join " + " $results)

    if test "$times" -gt 1
      echo $arg "»" (sum $total)
    else
      echo $arg "»" $total
    end

    set -a totals "($total)"
  end

  if test (count $totals) -gt 1
    set -l grand_total (string join " + " $totals)
    sum $grand_total
  end
end
