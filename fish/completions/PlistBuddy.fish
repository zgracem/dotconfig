function __fish_complete_PlistBuddy_commands
    set -l cmds \
        Help\t"Print help information" \
        Exit\t"Exit the program w/out saving" \
        Save\t"Save changes to the file" \
        Revert\t"Reload the last saved version" \
        Clear\t"Clear all entries and create root of TYPE" \
        Print\t"Print file or value of ENTRY" \
        Set\t"Set ENTRY to VALUE" \
        Add\t"Add ENTRY with value VALUE" \
        Copy\t"Copy ENTRYSRC to ENTRYDST" \
        Delete\t"Delete ENTRY from the plist" \
        Merge\t"Adds the contents of file to ENTRY" \
        Import\t"Create or set ENTRY to contents of file"

    printf '%s\n' $cmds
end

set -l no_flags "not __fish_seen_argument -s h -s c -s x"
set -l PlistBuddy_types string array dict bool real integer date data

complete -c PlistBuddy -rf
complete -c PlistBuddy -s h -n "$no_flags" -d "Print complete help info"
complete -c PlistBuddy -s x -n "$no_flags" -d "Output XML plist where appropriate"
complete -c PlistBuddy -s c -n "$no_flags" -xa "(__fish_complete_PlistBuddy_commands)" -d "Execute command and exit"
complete -c PlistBuddy -n "__fish_seen_subcommand_from Clear" -xa "$PlistBuddy_types"
complete -c PlistBuddy -n "__fish_seen_subcommand_from Print" -F
complete -c PlistBuddy -n "__fish_seen_subcommand_from Set" -x
complete -c PlistBuddy -n "__fish_seen_subcommand_from Add" -x
complete -c PlistBuddy -n "__fish_seen_subcommand_from Copy" -x
complete -c PlistBuddy -n "__fish_seen_subcommand_from Delete" -x
complete -c PlistBuddy -n "__fish_seen_subcommand_from Merge" -rF
complete -c PlistBuddy -n "__fish_seen_subcommand_from Import" -x
