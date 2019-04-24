function bat --description 'A cat clone with wings'
  set -l args
  for arg in $argv
    switch "$arg"
    case "cache" "-*"
      set -a args $arg
    case "*"
      if cygwin?
        set -a args (cygpath --windows $arg)
      else
        set -a args $arg
      end
    end
  end

  command bat $args
end
