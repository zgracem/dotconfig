_inPath qlmanage || return

ql()
{   # launch a QuickLook preview of a file
    quietly qlmanage -p "$@"
}
