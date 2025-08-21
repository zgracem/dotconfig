set -l _shortcuts_cmds '
    run\tRun\ a\ shortcut
    list\tList\ your\ shortcuts
    view\tView\ a\ shortcut\ in\ Shortcuts
    sign\tSign\ a\ shortcut\ file
    help\tShow\ help\ information
'

set -l _shortcuts_modes '
    people-who-know-me\tSign\ locally
    anyone\tNotarize\ via\ iCloud
'

complete -c shortcuts --erase

complete -c shortcuts -s h -l help -d "Show help information"
complete -c shortcuts -n '__fish_use_subcommand' -x -a $_shortcuts_cmds

complete -c shortcuts -n '__fish_seen_subcommand_from run view' -x -a "(shortcuts list)"
complete -c shortcuts -n '__fish_seen_subcommand_from run' -s i -l input-path -rF -d "Provide input to shortcut"
complete -c shortcuts -n '__fish_seen_subcommand_from run' -s o -l output-path -rF -d "Write shortcut output"
complete -c shortcuts -n '__fish_seen_subcommand_from run' -l output-type -x -d "UTI output format"

complete -c shortcuts -n '__fish_seen_subcommand_from list' -s f -l folder-name -x -a "(shortcuts list --folders; echo none\tNo\ folder)" -d Folder
complete -c shortcuts -n '__fish_seen_subcommand_from list' -l folders -d "List folders"
complete -c shortcuts -n '__fish_seen_subcommand_from list' -l show-identifiers -d "Show IDs with each result"

complete -c shortcuts -n '__fish_seen_subcommand_from sign' -s m -l mode -xa $_shortcuts_modes -d "Signing mode"
complete -c shortcuts -n '__fish_seen_subcommand_from sign' -s i -l input -rF -d "Shortcut files to sign"
complete -c shortcuts -n '__fish_seen_subcommand_from sign' -s o -l output -rF -d "Path for signed shortcut"

complete -c shortcuts -n '__fish_seen_subcommand_from help' -xa "run list view sign" -d "Help for subcommand"
