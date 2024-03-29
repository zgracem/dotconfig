complete --command vsx --exclusive
complete -c vsx -n __fish_use_subcommand -a install -d "Install all missing extensions in list"
complete -c vsx -n __fish_use_subcommand -a cleanup -d "Remove all unlisted extensions"
complete -c vsx -n __fish_use_subcommand -a list -d "List installed extensions"
complete -c vsx -n __fish_use_subcommand -a diff -d "Diff listed & installed extensions"
complete -c vsx -n __fish_use_subcommand -a json -d "List installed extensions as JSON"
complete -c vsx -n __fish_use_subcommand -a dump -d "Update the extensions file"
complete -c vsx -n __fish_use_subcommand -a sync -d "Install, then cleanup"
complete -c vsx -n __fish_use_subcommand -a completions -d "Print fish completions"
