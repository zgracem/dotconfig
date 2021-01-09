function oldprefexport -d "export defaults from \$file as YAML"
    set old_pref_dir /Volumes/Hub/Athena/Preferences

    set -l domain (basename -s .plist $argv[1])
    set old_pref_file $old_pref_dir/$domain.plist

    if not test -f "$old_pref_file"
        echo >&2 "file not found: $old_pref_file"
        return 1
    end

    if isatty stdout
        function _at; cat | bat -l yaml; end
    else
        function _at; cat; end
    end

    plutil -convert xml1 $old_pref_file -o - \
    | pyjamas --in plist --out yaml \
    | _at
end
