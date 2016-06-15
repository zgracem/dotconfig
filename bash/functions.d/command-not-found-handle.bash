# Only available in bash 4+
(( BASH_VERSINFO[0] >= 4 )) || return

# "If the search [for a command] is unsuccessful, the shell searches for a 
# defined shell function named command_not_found_handle. If that function 
# exists, it is invoked with the original command and the original command's 
# arguments as its arguments..."
# -- bash manual page

command_not_found_handle()
{
    local cmd="$1"; shift

    printf '%s\n' "${esc_false}${cmd}${esc_reset}: command not found" >&2

    return $EX_NOCMD
}
