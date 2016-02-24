lockfile()
{
    local -a files=("$@")

    case $OSTYPE in
        darwin*)
            sudo chflags uchg "${files[@]}"
            ;;
        cygwin)
            "${SYSTEMROOT}/system32/attrib" +R "${files[@]}"
            ;;
        *)
            scold 'not available on this system'
            return $EX_OSERR
            ;;
    esac

    chmod a-w "${files[@]}"
}

unlockfile()
{
    local -a files=("$@")

    case $OSTYPE in
        darwin*)
            sudo chflags nouchg "${files[@]}"
            ;;
        cygwin)
            "${SYSTEMROOT}/system32/attrib" +R "${files[@]}"
            ;;
        *)
            scold 'not available on this system'
            return $EX_OSERR
            ;;
    esac

    chmod u+w "${files[@]}"
}
