function console --description 'Scan system messages'
  set -l locations $argv[1] /var/log/system.log /var/log/messages

  for logfile in $locations
    test -r "$logfile"; and break
    set -e logfile
  end

  if test -z "$logfile"
    echo >&2 (status current-function)": no log file found"
    return 1
  end

  newwin --title=console -- tail -n $LINES -f $logfile
end
