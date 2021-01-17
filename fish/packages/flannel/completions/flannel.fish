complete -c flannel -n __fish_is_first_token -x -a "export import dump touch"
complete -c flannel -n "__fish_seen_subcommand_from export" -s b -l byhost -rF
complete -c flannel -n "__fish_seen_subcommand_from export" -s o -l old -rF
complete -c flannel -n "__fish_seen_subcommand_from import" -s n -l dryrun
