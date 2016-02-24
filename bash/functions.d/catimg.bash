catimg()
{
    if [[ $TERM_PROGRAM == iTerm.app ]] && _inPath imgcat; then
        imgcat "$@"
    elif _inPath catimg; then
        catimg "$@"
    else
        scold "not available :("
        return 1
    fi
}
