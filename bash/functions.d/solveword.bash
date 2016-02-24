solveword()
{   # crossword solver
    # http://hints.macworld.com/article.php?story=20080224044840101

    command grep -Es --colour=never "$@" /usr/share/dict/words \
    | column
}
