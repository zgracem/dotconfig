# shellcheck <https://www.shellcheck.net/>

complete -c shellcheck -s s -d 'POSIX compliant'
complete -c shellcheck -s a -l check-sourced -d 'Include warnings from sourced files'
complete -c shellcheck -s C -l color -r -a 'auto always never' -d 'Use color'
complete -c shellcheck -s e -l exclude -x -d 'Exclude types of warnings (CODE1,CODE2..)'
complete -c shellcheck -s f -l format -r -a 'checkstyle gcc json tty' -d 'Output format'
complete -c shellcheck -s s -l shell -r -a 'sh bash dash ksh' -d 'Specify dialect'
complete -c shellcheck -s S -l severity -r -a 'error warning info style' -d 'Minimum severity of errors to consider'
complete -c shellcheck -s V -l version -d 'Print version information and exit'
complete -c shellcheck -s W -l wiki-link-count -x -d 'The number of wiki links to show'
complete -c shellcheck -s x -l external-sources -d 'Allow "source" outside of FILES'
