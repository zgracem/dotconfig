# sf-pwgen <https://github.com/anders/pwgen>

complete -c sf-pwgen -s a -l algorithm -x -a 'memorable random letters alphanumeric numbers' -d 'Password algorithm'
complete -c sf-pwgen -s c -l count -x -d 'Number of passwords to generate'
complete -c sf-pwgen -s l -l length -x -d 'Length of the generated passwords'
complete -c sf-pwgen -s L -l language -x -a 'en de es fr it nl pt jp' -d 'Generate passwords in a specified language'
complete -c sf-pwgen -s h -l help -x -d 'Print help message'
complete -c sf-pwgen -s v -l version -x -d 'Print version number and exit'
