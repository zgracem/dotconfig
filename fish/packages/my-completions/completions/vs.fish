complete -c vs -f # do not operate on files

set -l vs_cmds help complete bundle test cleanup make media build sync deploy server commit readme
complete -c vs -n '__fish_is_first_token' -xa "$vs_cmds"
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from help' -xa "$vs_cmds"
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from complete' -xa 'write print'
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from test' -l build
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from test' -l cleanup
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from test' -l quiet
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from test' -l verbose
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from make' -xa 'all icon presszip thumbs'
complete -c vs -n '__fish_is_nth_token 3; and __fish_seen_subcommand_from make; and __fish_seen_subcommand_from thumbs' -xa 'all covers photos posters press'
complete -c vs -n '__fish_is_nth_token 4; and __fish_seen_subcommand_from help; and __fish_seen_subcommand_from make; and __fish_seen_subcommand_from thumbs' -xa 'all covers photos posters press'
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from media' -xa 'all source build'
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from build' -xa 'all site docs json fast'
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from sync' -xa 'all fast build docs json'
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from deploy' -xa 'all site docs json fast'
complete -c vs -n '__fish_is_nth_token 2; and __fish_seen_subcommand_from server' -xa 'site console docs'
