function _errno_fish --argument num
  test "$num" -ge 121 -a "$num" -le 127
  or return

  set -l fish_errors
    set fish_errors[121] "Invalid arguments"
    set fish_errors[123] "Command name contained invalid characters"
    set fish_errors[124] "Wildcard match failed"
    set fish_errors[125] "OS could not execute previous command"
    set fish_errors[126] "Previous command was not executable"
    set fish_errors[127] "Previous command was unknown"

  set fish_err $fish_errors[$num]
  echo -es "fish error" "\n    " $fish_err "."
end
