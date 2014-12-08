hexdump()
{
    local flags_hexdump='-C '	# "canonical" display mode

    command hexdump $flags_hexdump "$@"
}
