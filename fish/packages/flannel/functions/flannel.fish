function flannel
    argparse n/dryrun b/byhost=+ o/old=+ -- $argv; or return

    set -l host C8E68D40-A53C-50DE-90B4-4A5973272E7F
    set -l prefs_dir ~/Library/Preferences
    set -l old_prefs_dir /Volumes/Hub/Athena/Preferences

    switch $argv[1]
        case touch
            gtouch $FLANNEL_DRAWER/$argv[2..-1].yaml
        case export
            for byhost_file in $_flag_byhost
                set -a argv $prefs_dir/$byhost_file.$host.plist
            end

            set -q argv[2]; or set argv[2] -globalDomain

            for domain in $argv[2..-1]
                defaults export $domain - | pyjamas --mode plist:yaml
            end

            for file in $_flag_old
                set -l domain (basename -s .plist $argv[1])
                set -l old_pref_file $old_prefs_dir/$domain.plist

                if test -f "$old_pref_file"
                    plutil -convert xml1 $old_pref_file -o - | pyjamas --mode plist:yaml
                else
                    echo >&2 "file not found! $old_pref_file"
                    return 1
                end
            end
        case dump
            for domain in $argv[2..-1]
                set -l yaml_file $FLANNEL_DRAWER/$domain.yaml
                if test -f $yaml_file
                    echo >&2 "file exists!" $yaml_file
                    continue
                end
                flannel export $domain >$yaml_file
            end
        case import
            set -q _flag_dryrun; and set _flag_dryrun --dryrun
            __flannel_import $_flag_dryrun $argv[2..-1]
    end
end
