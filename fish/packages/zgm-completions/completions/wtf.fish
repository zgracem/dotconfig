complete -c wtf --require-parameter --force-files
complete -c wtf -a "(functions --names --all)" -d function
complete -c wtf -a "(builtin --names)" -d builtin
complete -c wtf -a "(abbr --list)" -d abbrev.

set -l token_switch --tokenize
fish-is-newer-than 4.0b1 # released Dec 2024
and set token_switch --tokens-expanded
complete -c wtf -a "(complete -C (printf %s\n (commandline $token_switch --current-token)))"
