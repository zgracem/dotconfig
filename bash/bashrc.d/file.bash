file()
{
    command file -p "$@"
    #             └─ don't touch last-accessed time
}
