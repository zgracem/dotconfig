# "If the search [for a command] is unsuccessful, the shell searches for a 
# defined shell function named command_not_found_handle. If that function 
# exists, it is invoked with the original command and the original command's 
# arguments as its arguments..."
#                                                     -- bash(1) manual page

# Only available in bash 4+
(( BASH_VERSINFO[0] >= 4 )) || return

command_not_found_handle()
{
  printf >&2 '%s\n' "${esc_false}${1}${esc_reset}: command not found"
  return 127
}
