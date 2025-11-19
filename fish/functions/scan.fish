function scan --description 'Scan for network information'
    set -lx ARITY_2 file pid port
    set -lx ARITY_1 fs ssh wifi
    set -lx COMMANDS $ARITY_1 $ARITY_2

    function _scan_commands
        for cmd in $COMMANDS
            if contains "$cmd" $ARITY_2
                echo "$cmd <$cmd>"
            else if contains "$cmd" $ARITY_1
                echo "$cmd"
            end
        end
    end

    function _scan_args
        if contains "$argv[1]" $ARITY_2
            set -q argv[2]; and return 0
        else if contains "$argv[1]" $ARITY_1
            not set -q argv[2]; and return 0
        else if set -q argv[1]
            echo "invalid subcommand: $argv[1]" >&2
        end

        _scan_usage $argv[1] >&2
        return 1
    end

    function _scan_usage -a cmd
        if contains "$cmd" $ARITY_2
            echo "Usage: scan $cmd <$cmd>"
        else if contains "$cmd" $ARITY_1
            echo "Usage: scan $cmd"
        else
            echo -s "Usage: scan [" (_scan_commands | string join "|") "]"
        end
    end

    _scan_args $argv; or return

    switch $argv[1]
        case file
            # Track access to a file
            sudo opensnoop -v -f $argv[2]
        case fs
            # Continuous stream of file system access info
            sudo fs_usage -w
        case pid
            # Track access by process ID
            sudo opensnoop -v -p $argv[2]
        case port
            # Track access on a port
            sudo lsof -i :$argv[2]
        case ssh
            # List all SSH-enabled hosts on the current domain
            dns-sd -B _ssh._tcp
        case ''
            _scan_usage $argv[1]
            return 1
    end
end
