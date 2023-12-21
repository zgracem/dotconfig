function div --description 'Print a divider across the terminal'
    argparse f/force -- $argv
    or return

    set -l symbol \u2500
    if set -q argv[1]
        set symbol (string sub -l1 $argv[1])
    end

    set -l line (string repeat -N -n$COLUMNS $symbol)
    if command -q lolcat
        echo $line | lolcat --spread 8 $_flag_force
    else
        set_color brwhite
        echo $line
        set_color normal
    end
end
