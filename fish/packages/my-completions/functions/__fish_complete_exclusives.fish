function __fish_complete_exclusives
    # Returns true if none of the switch names appear in the command line.
    # E.g.: __fish_complete_exclusives i ps r verbose
    set -l exclusive_args $argv
    for arg in $exclusive_args
        switch (string length $arg)
            case 2
                __fish_seen_argument -o $arg; and return 1
            case 1
                __fish_seen_argument -s $arg; and return 1
            case '*'
                __fish_seen_argument -l $arg; and return 1
        end
    end
    return 0
end
