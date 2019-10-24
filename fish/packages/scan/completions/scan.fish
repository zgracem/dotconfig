complete -c scan -n "__fish_is_first_token" -a wifi -f -d (__fish_describe_function _scan_wifi)
complete -c scan -n "__fish_is_first_token" -a ssh -f -d (__fish_describe_function _scan_ssh)
complete -c scan -n "__fish_is_first_token" -a fs -f -d (__fish_describe_function _scan_fs)
complete -c scan -n "__fish_is_first_token" -a port -r -d (__fish_describe_function _scan_port)
complete -c scan -n "__fish_is_first_token" -a pid -r -d (__fish_describe_function _scan_pid)
complete -c scan -n "__fish_seen_subcommand_from pid" -x -a "(__fish_complete_pids)"
complete -c scan -n "__fish_is_first_token" -a file -d (__fish_describe_function _scan_file)
