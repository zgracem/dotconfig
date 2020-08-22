function rl --description 'Reload configuration files'
  set -g rl_exit 0

  function _yikes
    echo >&2 "$argv"
    set -g rl_exit (math $rl_exit + 1)
    return $rl_exit
  end

  function __source_v
    for file in $argv
      if source $file
        short_home $file
      else
        _yikes "error sourcing file: $file"
        return 1
      end
    end
  end

  function _source_f
    if test -f "$argv[1]"
      __source_v "$argv[1]"
    else
      return 1
    end
  end

  if test (count $argv) -eq 0
    __source_v "$__fish_config_dir/config.fish"
    return
  end

  for arg in $argv
    set --local error_message "couldn't find file for ‘$arg’"

    switch "$arg"
    case colours
      set --erase -U __zgm_init_colours
    case keychain
      command killall ssh-agent 2>/dev/null
      set --erase -g SSH_AGENT_PID
    end

    if functions -q $arg
      set --local function_file (functions -D $arg)
      _source_f "$function_file"
        or _yikes "$error_message: $function_file"
    else
      _source_f "$__fish_config_dir/$arg.fish"
        or _source_f "$__fish_config_dir/conf.d/$arg.fish"
        or _yikes $error_message
    end
  end

  return $rl_exit
end
