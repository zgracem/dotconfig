complete -c flannel -n __fish_is_first_token -a "export import dump touch"
complete -c flannel -n "__fish_seen_subcommand export" -s b -l byhost -rF
complete -c flannel -n "__fish_seen_subcommand export" -s o -l old -rF
complete -c flannel -n "__fish_seen_subcommand import" -s n -l dryrun
