(( BASH_VERSINFO[0] >= 4 )) || return

command_not_found_handle()
{
    local cmd="$1"; shift

    printf '%s\n' "${esc_false}${cmd}${esc_null}: command not found" >&2

    return $EX_NOCMD
}
