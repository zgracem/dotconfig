function __fish_seen_scan_subcmd
  set -l scan_commands wifi ssh fs port pid file

  __fish_seen_subcommand_from $scan_commands
end

complete -c scan -n "not __fish_seen_scan_subcmd" -a wifi -d (__fish_describe_function _scan_wifi)
complete -c scan -n "not __fish_seen_scan_subcmd" -a ssh -d (__fish_describe_function _scan_ssh)
complete -c scan -n "not __fish_seen_scan_subcmd" -a fs -d (__fish_describe_function _scan_fs)
complete -c scan -n "not __fish_seen_scan_subcmd" -a port -d (__fish_describe_function _scan_port)
complete -c scan -n "not __fish_seen_scan_subcmd" -a pid -d (__fish_describe_function _scan_pid)
complete -c scan -n "__fish_seen_subcommand_from pid" -x -a "(__fish_complete_pids)"
complete -c scan -n "not __fish_seen_scan_subcmd" -a file -d (__fish_describe_function _scan_file)
