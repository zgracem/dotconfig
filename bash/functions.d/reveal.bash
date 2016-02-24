reveal()
{   # reveal $1 in Finder/Explorer
    if (( $# == 1 )); then
        local target="$1"        
    else
        return $EX_USAGE
    fi

    case $OSTYPE in
        darwin*)
            open -R "$target"
            ;;
        cygwin)
            cygstart --explore "$(dirname "$target")"
            ;;
        *)
            scold 'not available on this system'
            return $EX_OSERR
            ;;
    esac
}
