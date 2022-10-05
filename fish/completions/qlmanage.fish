function __fish_complete_qlmanage_stats
	set -l stats \
        "plugins,Generators list" \
        "server,quicklookd life info" \
        "memory,quicklookd memory consumption" \
        "burst,Stats about the last burst" \
        "threads,Concurrent accesses stats" \
        "other,Other info about quicklookd"

    string replace , \t $stats
end

function __fish_complete_qlmanage_r
	set -l opts \
        ",Force reloading Generators list" \
        "cache,Reset thumbnail disk cache"

    string replace , \t $opts
end

function __fish_complete_qlmanage_generators
    qlmanage -m plugins \
    | string replace -rf "^\s+([\w.-]+) -> (.*) \(\d[\d.]*\)" '$2'\t \
    | sort -u
end

function __fish_complete_qlmanage_types
    qlmanage -m plugins \
    | string replace -rf "^\s+([\w.-]+) -> (.*) \(\d[\d.]*\)" '$1'\t \
    | sort -u
end

set -l qlexcl -s r -s m -s t -s p -s h -s z

complete -c qlmanage -f
complete -c qlmanage -s r -n "not __fish_seen_argument $qlexcl" -xa "(__fish_complete_qlmanage_r)" -d "Force reloading Generators list"
complete -c qlmanage -s m -n "not __fish_seen_argument $qlexcl" -xa "(__fish_complete_qlmanage_stats)" -d "Display statistics"
complete -c qlmanage -s t -n "not __fish_seen_argument $qlexcl" -F -d "Compute thumbnails"
complete -c qlmanage -s p -n "not __fish_seen_argument $qlexcl" -F -d "Compute previews"
complete -c qlmanage -s h -n "not __fish_seen_argument $qlexcl" -d "Display help"
complete -c qlmanage -s x -n "__fish_seen_argument -s t -s p" -d "Use quicklookd/remote computation"
complete -c qlmanage -s i -n "__fish_seen_argument -s t" -d "Compute thumbnail in icon mode"
complete -c qlmanage -s s -n "__fish_seen_argument -s t" -x -d "Thumb size"
complete -c qlmanage -s f -n "__fish_seen_argument -s t" -x -d "Thumb scale factor"
complete -c qlmanage -s F -n "__fish_seen_argument -s t" -x -d "Thumb downscale factor"
complete -c qlmanage -s z -n "not __fish_seen_argument $qlexcl" -d "Only display performance info"
complete -c qlmanage -s o -n "not __fish_seen_argument -s h" -rF -d "Only output result in DIR"
complete -c qlmanage -s c -n "__fish_seen_argument -s t -s p" -xa "(__fish_complete_qlmanage_types)" -d "Force content type"
complete -c qlmanage -s g -n "__fish_seen_argument -s t -s p; and __fish_seen_argument -s c" -xa "(__fish_complete_qlmanage_generators)" -d "Force generator"
