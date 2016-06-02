# functions -- for `where`
complete -A function \
    -o nospace \
    where

# variables -- for `whatvar`
complete -ev -A arrayvar \
    -o nospace \
    whatvar

# files, aliases, builtins, commands, keywords, functions & helptopics -- for `which` & `what`
complete -f -abck -A function -A helptopic \
    -o nospace \
    which what

# aliases, builtins, commands, keywords & helptopics -- for `h`
complete -abck -A helptopic \
    -o nospace \
    h
