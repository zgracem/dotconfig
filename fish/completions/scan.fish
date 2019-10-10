function __fish_seen_scan_subcmd
  set -l scan_commands wifi ssh fs port pid file

  __fish_seen_subcommand_from $scan_commands
end

complete -c scan -n "not __fish_seen_scan_subcmd" -a wifi -d 'List all public SSIDs nearby'
complete -c scan -n "not __fish_seen_scan_subcmd" -a ssh -d 'List all SSH-enabled hosts on the current domain'
complete -c scan -n "not __fish_seen_scan_subcmd" -a fs -d 'Continuous stream of file system access info'
complete -c scan -n "not __fish_seen_scan_subcmd" -a port -d 'Track access on <port>'
complete -c scan -n "not __fish_seen_scan_subcmd" -a pid -d 'Track access by process ID'
complete -c scan -n "__fish_seen_subcommand_from pid" -x -a "(__fish_complete_pids)"
complete -c scan -n "not __fish_seen_scan_subcmd" -a file -d 'Track access to a file'
