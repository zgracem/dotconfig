# xattr

complete -c xattr -s p -x -d "Print value of attr_name"
complete -c xattr -s w -x -d "Write to attr_name with attr_value"
complete -c xattr -s d -x -d "Delete attr_name"
complete -c xattr -s c -d "Clear all xattrs"

complete -c xattr -s h -d "Display help" -n __fish_is_first_arg
complete -c xattr -s l -d "Long format" -n "__fish_is_first_arg; or __fish_seen_argument -s p"
complete -c xattr -s r -d "Act recursively"
complete -c xattr -s s -d "Act on symlinks, not targets"
complete -c xattr -s v -d "Also print filenames" -n "__fish_is_first_arg; or __fish_seen_argument -s p"
complete -c xattr -s x -d "attr_value as hex" -n "__fish_is_first_arg; or __fish_seen_argument -s p -s w"
