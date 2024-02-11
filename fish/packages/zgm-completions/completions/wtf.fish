complete -c wtf --require-parameter --force-files
complete -c wtf -a "(functions --names --all)" -d function
complete -c wtf -a "(builtin --names)" -d builtin
complete -c wtf -a "(abbr --list)" -d abbrev.
complete -c wtf -a "(complete -C (printf %s\n (commandline --tokenize --current-token)))"
