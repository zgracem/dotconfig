complete -A function \
    -o nospace \
    where

complete -v \
    -o nospace \
    whatvar wv

complete -f -abck -A function -A helptopic \
    -o nospace \
    which what h
