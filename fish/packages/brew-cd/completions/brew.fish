set -gq __fish_complete_brew_cd; or set -g __fish_complete_brew_cd '
    cache\t'(command brew --cache)'
    caskroom\t'(command brew --caskroom)'
    cellar\t'(command brew --cellar)'
    prefix\t'(command brew --prefix)'
    repository\t'(command brew --repository)'
'

complete -c brew -a cd -d "Change to a Homebrew directory" -n __fish_use_subcommand
complete -c brew -x -a "$__fish_complete_brew_cd" -n '__fish_seen_subcommand_from cd'
