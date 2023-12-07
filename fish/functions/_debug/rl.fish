function rl --description "Reload configuration files"
    argparse 'v/verbose' -- $argv; or return

    set --global _rl_errors 0
    set --erase --local files_to_reload
    set --local files_to_reload
    set -q _flag_verbose; and set -lx verbose 1

    # Prints arguments to standard error
    function _yikes
        echo -e $argv >&2
    end

    # Prints each argument, with any leading $HOME replaced by "~"
    function _confirm
        set -qx verbose; and short_home $argv
    end

    # Checks whether $file exists:
    #   if it does, returns true;
    #   if not, updates the error counter and returns false.
    function _must_exist -a file
        if path is -f $file
            return 0
        else
            _increment_errors
            return 1
        end
    end

    # Checks whether $func is a defined, reloadable function:
    #   if $func was defined in an existing file, prints the path to stdout and returns true;
    #   if $func can't be reloaded, prints the reason to stderr and returns false;
    #   if $func is not defined, silently returns false.
    function _reloadable_function -a func
        set --local src (functions -D $func)
        set --local reason "file not found: $src"

        switch "$src"
            case "/*"
                _must_exist "$src"; and echo "$src"; and return 0
            case stdin
                set reason "defined interactively"
            case -
                set reason "defined via `source`"
            case n/a
                return 1
                # set reason "not defined"
        end

        _yikes "can’t reload function ‘$func’: $reason"
        return 1
    end

    # Attempts to source file argument:
    #   on success, prints the filename to stdout;
    #   on failure, prints a message to stderr and returns false.
    function __source_v -a file
        if source $file
            _confirm $file
        else
            set -l code $status
            _yikes "error sourcing file: $file"
            _increment_errors
            return $code
        end
    end

    # Checks if each argument exists as a file:
    #   if it does, tries to source it;
    #     on success, prints the filename to stdout;
    #     on failure, prints a message to stderr and continues;
    #   if it doesn't exist, silently continues;
    #   returns false if anything failed.
    function _source_all
        set --local code 0
        for file in $argv
            if _must_exist $file
                __source_v "$file"; or set code $status
            end
        end
        return (math $status + $code)
    end

    # Increments the error counter
    function _increment_errors -a inc
        set -q inc[1]; or set inc 1
        set --global _rl_errors (math "$_rl_errors + $inc")
    end

    # With no arguments, reload the main config file
    if not set -q argv[1]
        set --append files_to_reload "$__fish_config_dir/config.fish"
    end

    for arg in $argv
        set --erase --local checked_files

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
        set --local dirs_to_check "$__fish_config_dir" "$__fish_config_dir"/conf.d
        set --local files_to_check $dirs_to_check/"$arg.fish"

        for config_file in $files_to_check
            path is -f $config_file; and set --append checked_files $config_file
        end

        # Search functions
        if set --local function_file (_reloadable_function $arg)
            set --append checked_files $function_file
        end

        # Search completion dirs and take only the first result
        for completion_file in $fish_complete_path/"$arg.fish"
            if path is -f $completion_file
                set --append checked_files $completion_file
                break
            end
        end

        if set -q checked_files[1]
            set --append files_to_reload $checked_files
        else
            _increment_errors
            _yikes "nothing found for “$arg”"
        end
    end

    _source_all $files_to_reload
    return $_rl_errors
end
