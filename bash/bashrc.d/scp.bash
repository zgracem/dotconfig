scp()
{
    local flags_scp=
    flags_scp+='-C '    # compress
    flags_scp+='-p '    # preserve times/modes
    flags_scp+='-r '    # recursive

    command scp $flags_scp "$@"
}
