hidefile()
{
    local -a files=("$@")

    case $OSTYPE in
        darwin*)
            chflags hidden "${files[@]}"
            ;;
        cygwin)
            "${SYSTEMROOT}/system32/attrib" +H "${files[@]}"
            ;;
        *)
            scold 'not available on this system'
            return $EX_OSERR
            ;;
    esac
}

unhidefile()
{
    local -a files=("$@")

    case $OSTYPE in
        darwin*)
            chflags nohidden "${files[@]}"
            ;;
        cygwin)
            "${SYSTEMROOT}/system32/attrib" -H "${files[@]}"
            ;;
        *)
            scold 'not available on this system'
            return $EX_OSERR
            ;;
    esac
}
