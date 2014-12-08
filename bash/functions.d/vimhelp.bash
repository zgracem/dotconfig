vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
