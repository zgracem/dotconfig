function __fish_command_not_found_handler --on-event fish_command_not_found
  set cmd (string escape -- $argv[1])
  echo -s (set_color $fish_color_error) $cmd (set_color normal) ": command not found" >&2
  return 127
end
