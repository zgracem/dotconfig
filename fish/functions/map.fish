function map --description 'Apply a command to each item in a list'
  # Based on <http://redd.it/aks3u>
  set -l a
  set -l cmd
  set -l args
  set -l _command_complete 0

  for a in $argv
    if [ $_command_complete -eq 1 ]
      set args $args $a
    else if string match -q "*:" $a
      set cmd $cmd (string trim -rc: $a)
      set _command_complete 1
    else
      set cmd $cmd $a
    end
  end

  for a in $args
    eval (string escape $cmd) (string escape $a)
    or return
  end
end
