(( BASH_VERSINFO[0] >= 4 )) || return

command_not_found_handle()
{
    local cmd="$1"; shift

    printf '%s\n' "${esc_false}${cmd}${esc_null}: command not found" >&2

    return $EX_NOCMD
}

### ZGM disabled 2015-11-07 -- not useful, slow
# _homebrew_command_not_found_handle()
# {
#     local cmd="$1"; shift

#     _command_not_found_handle "$cmd"

#     if [[ -t 0 && -z $MC_SID ]]; then
#         local pkg; pkg=$(brew which-formula --explain "$cmd" 2>/dev/null)

#         if [[ -n $pkg ]]; then
#             printf '%s\n' "$pkg" >&2
#         fi
#     fi

#     return $EX_NOCMD
# }

# if [[ -d /usr/local/Library/Taps/homebrew/homebrew-command-not-found ]]; then
#     command_not_found_handle() { _homebrew_command_not_found_handle "$@"; }
# else
#     command_not_found_handle() { _command_not_found_handle "$@"; }
# fi
