set -l sd_described_cmds '
    create\tPlugin\ creation\ wizard
    link\tLink\ plugin\ to\ Deck
    unlink\tUnlink\ plugin\ from\ Deck
    list\tList\ installed\ plugins
    restart\tStart\ or\ restart\ plugin
    stop\tStop\ plugin
    dev\tEnable\ developer\ mode
    validate\tValidate\ plugin
    pack\tCreate\ .streamDeckPlugin\ file
    config\tManage\ local\ configuration
'
# Aliases: recognize as commands for completing options,
# but do not offer as completions in command position
set -l sd_cmds r s bundle
for cmd in (string trim $sd_described_cmds)
    set -a sd_cmds (string trim $cmd | string split -f1 '\t')
end

complete -c streamdeck --no-files
complete -c streamdeck -n __fish_is_first_arg -s h -l help -d "Display help"
complete -c streamdeck -n __fish_is_first_arg -s v -d "Display CLI version"
complete -c streamdeck -n __fish_is_first_arg -s l -l list -d "List installed plugins"
complete -c streamdeck -n __fish_use_subcommand -x -a $sd_described_cmds
complete -c streamdeck -n "__fish_seen_subcommand_from $sd_cmds" -s h -l help -d "Display help for command"
complete -c streamdeck -n "__fish_seen_subcommand_from link" -rF -d "Path to plugin"
complete -c streamdeck -n "__fish_seen_subcommand_from unlink" -s d -l delete -d "Delete non-linked plugins"
complete -c streamdeck -n "__fish_seen_subcommand_from unlink" -x # uuid
complete -c streamdeck -n "__fish_seen_subcommand_from list" -s a -l all -d "Show all plugins"
complete -c streamdeck -n "__fish_seen_subcommand_from r restart" -x # uuid
complete -c streamdeck -n "__fish_seen_subcommand_from s stop" -x # uuid
complete -c streamdeck -n "__fish_seen_subcommand_from dev" -s d -l disable -d "Disables developer mode"
complete -c streamdeck -n "__fish_seen_subcommand_from validate" -rF
complete -c streamdeck -n "__fish_seen_subcommand_from validate" -l force-update-check -d "Forces an update check"
complete -c streamdeck -n "__fish_seen_subcommand_from validate" -l no-update-check -d "Disables updating schemas"
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -rF
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -l dry-run -d "Generate report w/out creating package"
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -s f -l force -d "Overwrite package if it exists"
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -s o -l output -rF -d "Output directory"
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -l version -x -d "Plugin version"
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -l force-update-check -d "Force an update check"
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -l no-update-check -d "Disable updating schemas"
complete -c streamdeck -n "__fish_seen_subcommand_from bundle pack" -l ignore-validation -d "Bypass validation errors"
