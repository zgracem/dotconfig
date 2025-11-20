complete -c wtf --require-parameter --force-files
complete -c wtf -a "(functions --names --all)" -d function
complete -c wtf -a "(builtin --names)" -d builtin
complete -c wtf -a "(abbr --list)" -d abbrev.

if fish-is-newer-than 4.0b1 # released Dec 2024
    set -l token_switch -x # --tokens-expanded
else
    set -l token_switch -o # --tokenize
end
complete -c wtf -a "(complete -C (printf %s\n (commandline $token_switch --current-token)))"
