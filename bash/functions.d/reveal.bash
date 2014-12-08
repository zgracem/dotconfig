reveal()
{   # reveal a file in Explorer/the Finder instead of opening it
    local item="$1"

    if [[ -z $item ]]; then
        scold "Usage: $FUNCNAME FILE"
        return 1
    elif [[ ! -e $item ]]; then
        scold "$item: not found"
        return 1
    fi

    case $OSTYPE in
        darwin*)
            open -R "$item"
            ;;
        cygwin)
            $(cygpath --windir)/explorer /select, $(cygpath -w "$item")
            ;;
        *)
            scold 'not available on this system'
            return 1
            ;;
    esac
}
