function map --description 'Apply a command to each item in a list'
  # Usage: map cmd --switch: one two three
  # Same as: cmd --switch one; and cmd --switch two; and cmd --switch three
  # Based on <http://redd.it/aks3u>
  set -l cmd
  set -l cmd_argv
  set -l _command_complete 0

  for arg in $argv
    if test $_command_complete -eq 1
      set -a cmd_argv $arg
    else if string match -q -- "*:" $arg
      set -a cmd (string trim -rc: -- $arg)
      set _command_complete 1
    else
      set -a cmd $arg
    end
  end

  for argument in $cmd_argv
    eval (string escape -- $cmd) (string escape -- $argument)
    or return
  end
end
