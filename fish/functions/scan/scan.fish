function scan --description 'Scan for network information'
  set -l commands file fs pid port ssh wifi

  switch "$argv[1]"
    case $commands
      eval "_my_$argv[1]"
    case ''
      echo -s "Usage: scan <" (string join "|" $commands) ">" >&2
      return 1
    case '*'
      echo >&2 "error: don't know how to scan $argv[1]"
      return 1
  end
end
