set -l ls -c littlesnitch -p '/Applications/Little Snitch.app/Contents/Components/littlesnitch'
set -l sub __fish_seen_subcommand_from

complete $ls -s h -l help -d "Print a short help and exit"
complete $ls -n __fish_is_first_token -x -a capture-traffic -d "Captures traffic of a particular process or process pair"
complete $ls -n __fish_is_first_token -x -a debug-categories -d "Sets categories to be logged in more detail"
complete $ls -n __fish_is_first_token -x -a export-model -d "Exports the entire data model in JSON format (backup)"
complete $ls -n __fish_is_first_token -x -a list-preferences -d "Lists all preferences"
complete $ls -n __fish_is_first_token -x -a log -d "Reads Little Snitch log messages"
complete $ls -n __fish_is_first_token -x -a log-traffic -d "Prints data from traffic log"
complete $ls -n __fish_is_first_token -x -a profile -d "Activates or deactivates profiles"
complete $ls -n __fish_is_first_token -x -a read-preference -d "Reads a preference value"
complete $ls -n __fish_is_first_token -x -a recrypt-config -d "Copies configuration files changing encryption password"
complete $ls -n __fish_is_first_token -x -a restore-model -d "Restores the current data model from backup"
complete $ls -n __fish_is_first_token -x -a restrictions -d "Show restrictions"
complete $ls -n __fish_is_first_token -x -a rulegroup -d "Enables or disables rule groups and blocklists"
complete $ls -n __fish_is_first_token -x -a update-rule-groups -d "Updates factory rule groups with rules for currently installed apps"
complete $ls -n __fish_is_first_token -x -a write-preference -d "Writes a preference value"

complete $ls -n "$sub capture-traffic; and __fish_is_nth_token 2" -rF -d "process path"
complete $ls -n "$sub capture-traffic; and __fish_is_nth_token 3" -rF -d "output file"
complete $ls -n "$sub capture-traffic" -s p -l pcap -d "Use pcap output format."
complete $ls -n "$sub capture-traffic" -s v -l via -rF -d "Capture only if the connecting is made via the given helper process."

complete $ls -n "$sub debug-categories" -x -d "category name"
complete $ls -n "$sub debug-categories" -s a -l add -d "Add to current set of categories."
complete $ls -n "$sub debug-categories" -s d -l delete -d "Delete from current set of categories."
complete $ls -n "$sub debug-categories" -s s -l set -d "Set current set of categories."
complete $ls -n "$sub debug-categories" -s f -l factory-reset -d "Reset to factory default."

complete $ls -n "$sub export-model" -rF -d "output file"

complete $ls -n "$sub list-preferences" -s g -l global-only -d "Show only preferences affecting all users."
complete $ls -n "$sub list-preferences" -s u -l user-only -d "Show only preferences affecting the current user."

complete $ls -n "$sub log" -s s -l stream -d "Live stream log messages."
complete $ls -n "$sub log" -s a -l all -d "Also show log messages from frameworks."
complete $ls -n "$sub log" -s f -l frameworks-only -d "Show log messages from frameworks only."
complete $ls -n "$sub log" -s d -l show-debug -d "Show debug messages from frameworks."
complete $ls -n "$sub log" -s j -l json -d "Output in JSON format."

set -l littlesnitch_times '
    10m\t10\ minutes\ (default)
    1h\t1\ hour
    3d\t 3\ days
'
complete $ls -n "$sub log" -s l -l last -x -a $littlesnitch_times -d "Show entries not older than the given time."
complete $ls -n "$sub log" -s p -l predicate -x -d "Use the given predicate string to filter messages."

complete $ls -n "$sub log-traffic" -s b -l begin-date -x -d "Where to begin reading logged traffic history."
complete $ls -n "$sub log-traffic; and not __fish_seen_argument -s s -l stream" -s e -l end-date -x -d "Where to stop reading logged traffic history."
complete $ls -n "$sub log-traffic; and not __fish_seen_argument -s e -l end-date" -s s -l stream -d "Stream live traffic statistics."

complete $ls -n "$sub profile" -s a -l activate -x -d "Activate the profile."
complete $ls -n "$sub profile" -s d -l deactivate-all -d "Deactivate all profiles."

complete $ls -n "$sub read-preference" -x -d "preference key"

complete $ls -n "$sub recrypt-config" -rF -d "config file path"
complete $ls -n "$sub recrypt-config" -s c -l current-password -x -d "Use this password for decrypting current configuration."
complete $ls -n "$sub recrypt-config" -s p -l password -x -a none\tdefault -d "Write out configuration files using this encryption key."

complete $ls -n "$sub restore-model" -n "__fish_is_nth_token 2" -rF -d "input file"
complete $ls -n "$sub restore-model" -s l -l list-users -d "Do not actually restore, just list users contained in the file."
complete $ls -n "$sub restore-model" -s t -l preserve-terminal-access -d "If Terminal access is currently enabled, preserve it regardless of imported settings."
complete $ls -n "$sub restore-model" -s m -l map-users -x -d "Provide a mapping between backup and local user-IDs."
complete $ls -n "$sub restore-model" -s p -l password -x -d "Little Snitch Encryption Key"

complete $ls -n "$sub rulegroup" -s e -l enable -x -d "Enable the rule group or blocklist."
complete $ls -n "$sub rulegroup" -s d -l disable -x -d "Disable the rule group or blocklist."

complete $ls -n "$sub write-preference" -n "__fish_is_nth_token 2" -x -d "key"
complete $ls -n "$sub write-preference" -n "__fish_is_nth_token 3" -x -d "value"
complete $ls -n "$sub write-preference" -s r -l remove -d "Remove the value for the given key."

complete $ls -n "$sub update-rule-groups" -s a -l apple-apps -d "Update Apple Applications group only."
complete $ls -n "$sub update-rule-groups" -s t -l third-party-apps -d "Update Third Party Applications group only."
