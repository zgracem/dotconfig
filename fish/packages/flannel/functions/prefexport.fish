function prefexport -d "export defaults from \$domain as YAML"
    test -n "$argv[1]"; or set argv[1] -globalDomain

    for domain in $argv
        if string match -q 'ByHost/*'
            set host C8E68D40-A53C-50DE-90B4-4A5973272E7F
            set pref_dir $HOME/Library/Preferences
            set domain "$pref_dir/$domain.$host.plist"
        end

        defaults export $domain - | pyjamas --in plist --out yaml
    end
end
