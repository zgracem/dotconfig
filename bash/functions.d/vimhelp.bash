vimhelp()
{   # load vim's inline help for topic $1
    newwin vim -c "help $1" -c only
}
