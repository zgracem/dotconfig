set -l opts "not __fish_seen_argument -o apps -o libs -o all"

complete -c lsregister -F
complete -c lsregister -n "$opts -s h" -o delete -d "Delete Launch Services database"
complete -c lsregister -n "$opts -s h" -o kill -d "Reset Launch Services database"
complete -c lsregister -n "$opts -s h" -o seed -d "Scan default locations"
complete -c lsregister -n "$opts -s h" -o lint -d "Print plist errors while registering"
complete -c lsregister -n "$opts -s h" -o lazy -x -d "Sleep n seconds before "
complete -c lsregister -n "$opts -s h" -s r -d "Recursive, no packages or invisibles"
complete -c lsregister -n "$opts -s h" -s R -d "Recursive, incl. packages & invisibles"
complete -c lsregister -n "$opts -s h" -s f -d "Force update even if unchanged"
complete -c lsregister -n "$opts -s h" -s u -d "Unregister instead"
complete -c lsregister -n "$opts -s h" -s v -d "Display progress info"
complete -c lsregister -n "$opts -s h" -o gc -d "Garbage collect & compact the database"
complete -c lsregister -n "$opts -s h" -o dump -x -d "Display full database after registration"
complete -c lsregister -n "$opts" -s h -d "Display help"

function __complete_lsregister_domains
    set -l lsdomains system local network user
    echo -ns $lsdomains\t\n
end

complete -c lsregister -o apps -x -a "(__fish_complete_list , __complete_lsregister_domains)"
complete -c lsregister -o libs -x -a "(__fish_complete_list , __complete_lsregister_domains)"
complete -c lsregister -o all -x -a "(__fish_complete_list , __complete_lsregister_domains)"
