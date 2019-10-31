set -l fish_version_parts major minor patch revision commit state

complete -c fish_version -x
complete -c fish_version -n "not __fish_seen_subcommand_from $fish_version_parts" -a "$fish_version_parts"
