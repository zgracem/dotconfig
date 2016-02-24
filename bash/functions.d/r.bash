r()
{   # reveal a file in Explorer/the Finder instead of opening it
    local item="${1-.}"

    if [[ ! -e $item ]]; then
        scold "$item: not found"
        return $EX_DATAERR
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
            return $EX_OSERR
            ;;
    esac
}
