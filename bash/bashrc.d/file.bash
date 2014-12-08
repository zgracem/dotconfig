file()
{
    local flags_file='-p '	# don't touch last-accessed time

    command file $flags_file "$@"
}
