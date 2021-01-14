function oldprefexport -d "export defaults from \$file as YAML"
    set old_prefs_dir /Volumes/Hub/Athena/Preferences

    set -l domain (basename -s .plist $argv[1])
    set old_pref_file $old_prefs_dir/$domain.plist

    if not test -f "$old_pref_file"
        printf >&2 "file not found: %s\n" $old_pref_file
        return 1
    end

    plutil -convert xml1 $old_pref_file -o - | pyjamas --mode plist:yaml
end
