function rl --description 'Reload configuration files'
  if test (count $argv) -eq 0
    source "$__fish_config_dir/config.fish"
    return
  end

  set -l errors 0
  for arg in $argv
    set -l error_message "couldn't find file for ‘$arg’"

    switch "$arg"
    case colours
      set --erase -U __zgm_init_colours
    end

    if functions -q $arg
      set -l function_file (functions -D $arg)
      if test -f "$function_file"
        source "$function_file"
        or set errors (math $errors + 1)
      else
        echo >&2 "$error_message: $function_file"
        set errors (math $errors + 1)
      end
    else if test -f "$__fish_config_dir/$arg.fish"
      source "$__fish_config_dir/$arg.fish"
      or set errors (math $errors + 1)
    else if test -f "$__fish_config_dir/conf.d/$arg.fish"
      source "$__fish_config_dir/conf.d/$arg.fish"
      or set errors (math $errors + 1)
    else
      echo >&2 $error_message
      set errors (math $errors + 1)
    end
  end

  return $errors
end
