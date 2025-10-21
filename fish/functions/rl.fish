function rl --description "Reload configuration files"
    argparse 'v/verbose' -- $argv; or return

    set -q _flag_verbose; and set -fx VERBOSE 1
    set -f _rl_errors 0
    set --erase -f files_to_reload
    set -f files_to_reload

    # Checks whether $func is a defined, reloadable function:
    #   if $func was defined in an existing file, prints the path to stdout and returns true;
    #   if $func can't be reloaded, prints the reason to stderr and returns false;
    #   if $func is not defined, silently returns false.
    function _rl_can_reload -a func
        set -f src (functions -D $func)
        set -f reason "file not found: $src"

        switch "$src"
            case "/*"
                if path is -f "$src"
                    echo "$src"
                    and return 0
                else
                    _rl_increment_errors
                    return 1
                end
            case stdin
                set reason "defined interactively"
            case -
                set reason "defined via `source`"
            case n/a
                return 1
                # set reason "not defined"
        end

        echo >&2 "can’t reload function ‘$func’: $reason"
        return 1
    end

    # Checks if each argument exists as a file:
    #   if it does, tries to source it;
    #     on success, prints the filename to stdout;
    #     on failure, prints a message to stderr and continues;
    #   if it doesn't exist, silently continues;
    #   returns false if anything failed.
    function _rl_source_all
        set -f errcode 0
        for file in $argv
            if path is -f $file
                if source "$file"
                    set -q VERBOSE; and my-prompt-pwd -Z $file
                    continue
                else
                    set errcode $status
                    echo >&2 "error sourcing file: $file"
                    _rl_increment_errors
                end
            else
                _rl_increment_errors
            end
        end
        return (math $status + $errcode)
    end

    # Increments the error counter
    function _rl_increment_errors -a inc
        set -q inc[1]; or set inc 1
        set _rl_errors (math "$_rl_errors + $inc")
    end

    # With no arguments, reload the main config file
    if not set -q argv[1]
        set --append files_to_reload "$__fish_config_dir/config.fish"
    end

    set -f dirs_to_check "$__fish_config_dir" "$__fish_config_dir"/conf.d
    for arg in $argv
        set --erase -f checked_files

        # Some reloads require other actions first
        switch "$arg"
            case colours
                set -l colour_vars (set -n \
                    | string match -rg '(fish_(?:[a-z]+_)*color_\w+)|([[:upper:]]+_COLORS)')
                set --erase -U $colour_vars __zgm_init_colours
            case keychain
                killall -v ssh-agent
                set --erase -g SSH_AGENT_PID
            case prompt
                set --prepend checked_files $__fish_config_dir/prompt/{conf.d,functions}/*.fish
        end

        # Search config dirs
        set -f files_to_check $dirs_to_check/"$arg.fish"

        for config_file in $files_to_check
            path is -r $config_file; and set --append checked_files $config_file
        end

        # Search functions
        if set -f function_file (_rl_can_reload $arg)
            set --append checked_files $function_file
        end

        # Search completion dirs and take only the first result
        for completion_file in $fish_complete_path/"$arg.fish"
            if path is -r $completion_file
                set --append checked_files $completion_file
                break
            end
        end

        if set -q checked_files[1]
            set --append files_to_reload $checked_files
        else
            _rl_increment_errors
            echo >&2 "nothing found for “$arg”"
        end
    end

    _rl_source_all $files_to_reload
    functions --erase (functions --names --all | string match -e "_rl_*")
    return $_rl_errors
end
