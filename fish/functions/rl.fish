function rl --description "Reload configuration files"
    argparse v/verbose -- $argv
    or return

    set -f found 0

    if not set -q argv[1]
        _rl_reset --all
        exec fish
    end

    for item in $argv
        _rl_reset $_flag_verbose $item

        # Is it a file that can be sourced?
        set -f confdirs $__fish_config_dir{,/**/conf.d}
        for file in (path filter $confdirs/$item.fish)
            set -f found (math "$found+1")
            _rl_source $_flag_verbose $file
            or return
        end

        set -f envdirs $XDG_CONFIG_HOME $XDG_CONFIG_HOME/../.private $__fish_config_dir
        for envfile in (path filter $envdirs/env.d/$item.{env,fish})
            set -f found (math "$found+1")
            _rl_source $_flag_verbose $envfile
            or return
        end

        # Is it a function that can be reloaded?
        set -f funcfile (functions -D $item)
        switch $funcfile
            case "/*"
                if path is -f $funcfile
                    set -f found (math "$found+1")
                    _rl_source $_flag_verbose $funcfile
                    or return
                else
                    echo >&2 "can't reload $item(): file not found: $funcfile"
                    return 1
                end
            case - stdin
                echo >&2 "can't reload $item(): no source file"
                return 1
        end

        # Are there completions that can be reloaded?
        for compfile in (path filter $fish_complete_path/$item.fish)
            set -f found (math "$found+1")
            _rl_source $_flag_verbose $compfile
            or return
        end

        # Is it a special case?
        switch $item
            case cygwin dirs
                set -f found (math "$found+1")
                _rl_source $_flag_verbose $__fish_config_dir/conf.d/___$item.fish
        end
    end

    if test $found -gt 0
        set -q _flag_verbose[1]; and echo "$found file(s) reloaded"
        return
    else
        echo >&2 "nothing found for '$item'"
        return 1
    end
end

function _rl_source
    argparse v/verbose -- $argv
    or return

    for file in $argv
        if source $file
            set -q _flag_verbose[1]
            and short_home (path resolve $file)
        else
            set -l source_exit $status
            echo >&2 "failed to source file: $file"
            return $source_exit
        end
    end
end

function _rl_reset
    argparse a/all v/verbose -- $argv
    or return

    if set -q _flag_all[1]
        _rl_reset env colours keychain
        return
    end

    for item in $argv
        switch $item
            case env
                set -q _flag_verbose[1]; and echo '[RESET] $__z_env_loaded'
                set -g --erase __z_env_loaded
            case colours
                set -l colour_vars (set -n \
                    | string match -rg '(fish_(?:[a-z]+_)*color_\w+)|([[:upper:]]+_COLORS)')
                set -q _flag_verbose[1]; and echo '[RESET] $__zgm_init_colours' '$'$colour_vars
                set -U --erase __zgm_init_colours $colour_vars
            case keychain
                if set -q _flag_verbose[1]
                    killall -v ssh-agent
                else
                    killall ssh-agent
                end 2>/dev/null
                set -q _flag_verbose[1]; and echo '[RESET] $SSH_AGENT_PID'
                set -g --erase SSH_AGENT_PID
            case '*'
                continue
        end
    end
end
