# Sublime Merge
complete -c smerge -s n -l new-window -d 'Open a new window'
complete -c smerge -s b -l background -d 'Don\'t activate the application'
complete -c smerge -s h -l help -d 'Show help (this message) and exit'
complete -c smerge -s v -l version -d 'Show version and exit'
complete -c smerge -a 'search' -r -d 'Search for commits in the current repository'
complete -c smerge -a 'blame' -r -d 'Blame the given file in the current repo'
complete -c smerge -a 'log' -r -d 'Show the file history in the current repo'
complete -c smerge -a 'mergetool' -r -d 'Open the merge tool for the given files'
