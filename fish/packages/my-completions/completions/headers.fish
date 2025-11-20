complete -c headers -s w -l wget -n "not __fish_seen_argument -s c -l curl" -d "Use wget"
complete -c headers -s c -l curl -n "not __fish_seen_argument -s w -l wget" -d "Use curl"
