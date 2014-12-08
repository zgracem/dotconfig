f()
{   # open a Finder/Explorer window for the current/specified directory
    local here="${1-.}"

    case $OSTYPE in
        darwin*)
            open -a Finder "$here"
            ;;
        cygwin)
            cygstart --explore "$here"
            ;;
        *)
            scold 'not available on this system'
            return 1
            ;;
    esac
}
