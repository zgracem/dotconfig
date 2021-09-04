complete -c scan -n "__fish_is_nth_token 1" -a wifi -f -d (__fish_describe_function _scan_wifi)
complete -c scan -n "__fish_is_nth_token 1" -a ssh -f -d (__fish_describe_function _scan_ssh)
complete -c scan -n "__fish_is_nth_token 1" -a fs -f -d (__fish_describe_function _scan_fs)
complete -c scan -n "__fish_is_nth_token 1" -a port -r -d (__fish_describe_function _scan_port)
complete -c scan -n "__fish_is_nth_token 1" -a pid -r -d (__fish_describe_function _scan_pid)
complete -c scan -n "__fish_seen_subcommand_from pid" -x -a "(__fish_complete_pids)"
complete -c scan -n "__fish_is_nth_token 1" -a file -d (__fish_describe_function _scan_file)
