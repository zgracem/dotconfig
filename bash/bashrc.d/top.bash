top()
{
    local flags_top='-F -R -u -user $USER'

    command top $flags_top "$@"
}
