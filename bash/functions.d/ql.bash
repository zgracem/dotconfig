[[ $OSTYPE =~ darwin ]] || return

ql()
{   # launch a QuickLook preview of a file
    quietly qlmanage -p "$@"
}
