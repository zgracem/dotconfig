function div --description 'Print a divider across the terminal'
    set -l symbol \u2500
    if set -q argv[1]
        set symbol (string sub -l1 $argv[1])
    end

    set -l line (string repeat -N -n$COLUMNS $symbol)
    if command -sq lolcat
        echo $line | lolcat --spread 8
    else
        echo -s (set_color brwhite) $line (set_color normal)
    end
end
