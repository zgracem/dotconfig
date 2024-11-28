# NOTE: Uses custom `__fish_complete_signals` function from:
#   $__fish_config_dir/packages/completion-helpers/functions/__fish_complete_signals.fish

#=> gui/501/com.apple.example
function __fish_complete_launchctl_service_targets
    launchctl print - 2>&1 | string match -r "^(?:gui|pid|system|user)/.+"
end

#=> gui/501/
function __fish_complete_launchctl_domain_targets
    __fish_complete_launchctl_service_targets \
        | string match -r "^(?:system/|(?:gui|pid|user)/\d+/)" \
        | sort -u
end

#=> com.apple.example
function __fish_complete_launchctl_service_names
    launchctl list | string split -n -f3 \t
end

set -l launchctl_domain_service_cmds bootstrap bootout enable disable kickstart attach debug blame print
set -l launchctl_domain_cmds print-disabled
set -l launchctl_label_cmds remove start stop list
set -l launchctl_sessiontypes '
    Aqua\tdefault
    Background
    LoginWindow
'

complete -c launchctl -n "__fish_seen_subcommand_from $launchctl_domain_service_cmds" -xa "(__fish_complete_launchctl_service_targets)"
complete -c launchctl -n "__fish_seen_subcommand_from $launchctl_domain_cmds" -xa "(__fish_complete_launchctl_domain_targets)"
complete -c launchctl -n "__fish_seen_subcommand_from $launchctl_label_cmds" -xa "(__fish_complete_launchctl_service_names)"

complete -c launchctl -n __fish_use_subcommand -xa bootstrap -d "Bootstrap a domain or service"
complete -c launchctl -n __fish_use_subcommand -xa bootout -d "Teardown a domain or remove a service"
complete -c launchctl -n __fish_use_subcommand -xa enable -d "Enable a service"
complete -c launchctl -n __fish_use_subcommand -xa disable -d "Disable a service"
complete -c launchctl -n __fish_use_subcommand -xa kickstart -d "Force a service to start"
complete -c launchctl -n "__fish_seen_subcommand_from kickstart attach" -s k -d "Kill service if running"
complete -c launchctl -n "__fish_seen_subcommand_from kickstart" -s p -d "Print PID on success"
complete -c launchctl -n __fish_use_subcommand -xa attach -d "Attach the system's debugger to a service"
complete -c launchctl -n "__fish_seen_subcommand_from attach" -s s -d "Force service to start"
complete -c launchctl -n "__fish_seen_subcommand_from attach" -s x -d "Attach to xpcproxy(3) before exec"
complete -c launchctl -n __fish_use_subcommand -xa debug -d "Configure next invocation for debugging"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l program -rF -d "Set service's executable"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l guard‐malloc -d "Turn on libgmalloc(3)"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l malloc‐stack‐logging -d "Turn on malloc(3) stack logging"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l malloc‐nano-allocator -d "Turn on malloc(3) nano allocator"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l debug‐libraries -d "Prefer debug libraries"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l introspection‐libraries -d "Prefer introspection libraries"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l NSZombie -d "Enable NSZombie"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l 32 -d "Run in 32-bit architecture"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l stdin -rF -d "Set path to stdin"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l stdout -rF -d "Set path to stdout"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l stderr -rF -d "Set path to stderr"
complete -c launchctl -n "__fish_seen_subcommand_from debug" -l environment -x -d "Set environment variable(s)"
complete -c launchctl -n __fish_use_subcommand -xa kill -d "Send signal to service instance"
complete -c launchctl -n "__fish_seen_subcommand_from kill" -x -a "(__fish_complete_signals)"
complete -c launchctl -n __fish_use_subcommand -xa blame -d "Print the reason a service is running"
complete -c launchctl -n __fish_use_subcommand -xa print -d "Describe a domain or service"
complete -c launchctl -n __fish_use_subcommand -xa print-cache -d "Print info about the cache"
complete -c launchctl -n __fish_use_subcommand -xa print-disabled -d "Print disabled services"
complete -c launchctl -n __fish_use_subcommand -xa plist -d "Print binary-embedded property list"
complete -c launchctl -n "__fish_seen_subcommand_from plist" -x -a "segment section"
complete -c launchctl -n __fish_use_subcommand -xa procinfo -d "Get port info about a process"
complete -c launchctl -n "__fish_seen_subcommand_from procinfo" -x -a "(__fish_complete_pids)"
complete -c launchctl -n __fish_use_subcommand -xa hostinfo -d "Get port info about the host"
complete -c launchctl -n __fish_use_subcommand -xa resolveport -d "Resolve port name from process to endpoint"
complete -c launchctl -n "__fish_seen_subcommand_from resolveport" -x -a "(__fish_complete_pids)"
complete -c launchctl -n __fish_use_subcommand -xa examine -d "Run an analysis tool"
complete -c launchctl -n "__fish_seen_subcommand_from examine" -rF
complete -c launchctl -n __fish_use_subcommand -xa config -d "Modify config params for domains"
complete -c launchctl -n "__fish_seen_subcommand_from config" -xa "system user" -d domain
complete -c launchctl -n __fish_use_subcommand -xa reboot -d "Initiate a system reboot"
complete -c launchctl -n "__fish_seen_subcommand_from reboot" -xa "system userspace halt logout apps" -d reboot
complete -c launchctl -n __fish_use_subcommand -xa error -d "Describe error"
complete -c launchctl -n "__fish_seen_subcommand_from error" -xa "posix mach bootstrap" -d subsystem
complete -c launchctl -n __fish_use_subcommand -xa variant -d "Print launchd variant"
complete -c launchctl -n __fish_use_subcommand -xa version -d "Print launchd version"

# ----------------------------------------------------------------------------
# LEGACY SUBCOMMANDS
# ----------------------------------------------------------------------------

complete -c launchctl -n __fish_use_subcommand -xa load -d "Bootstrap service or directory"
complete -c launchctl -n __fish_use_subcommand -xa unload -d "Unload service or directory"
complete -c launchctl -n "__fish_seen_subcommand_from load unload" -s w -d "Override Disabled key"
complete -c launchctl -n "__fish_seen_subcommand_from load unload" -s F -d "Force and ignore Disabled key"
complete -c launchctl -n "__fish_seen_subcommand_from load unload" -s S -xa "$launchctl_sessiontypes" -d "Session type"
complete -c launchctl -n "__fish_seen_subcommand_from load unload" -s D -xa "system local all" -d "Search path"
complete -c launchctl -n "__fish_seen_subcommand_from load unload; and __fish_seen_argument -s S" -s D -xa "system local user all" -d "Search path"
complete -c launchctl -n __fish_use_subcommand -xa submit -d "Submit a basic job"
complete -c launchctl -n "__fish_seen_subcommand_from submit" -s l -x -d Label
complete -c launchctl -n "__fish_seen_subcommand_from submit" -s p -rF -d Program
complete -c launchctl -n "__fish_seen_subcommand_from submit" -s o -rF -d "Path to stdout"
complete -c launchctl -n "__fish_seen_subcommand_from submit" -s e -rF -d "Path to stderr"
complete -c launchctl -n __fish_use_subcommand -xa remove -d "Unload service"
complete -c launchctl -n __fish_use_subcommand -xa start -d "Start a service"
complete -c launchctl -n __fish_use_subcommand -xa stop -d "Stop a service"
complete -c launchctl -n __fish_use_subcommand -xa list -d "List info about services"
complete -c launchctl -n __fish_use_subcommand -xa setenv -d "Set environment variable"
complete -c launchctl -n __fish_use_subcommand -xa unsetenv -d "Unset environment variable"
complete -c launchctl -n __fish_use_subcommand -xa getenv -d "Get value of environment variable"
complete -c launchctl -n "__fish_seen_subcommand_from setenv unsetenv getenv" -xa "(set --names)"
complete -c launchctl -n __fish_use_subcommand -xa export -d "Export all environment variables"
complete -c launchctl -n __fish_use_subcommand -xa limit -d "Read or modify launchd resource limits"
complete -c launchctl -n "__fish_seen_subcommand_from limit" -xa "cpu filesize data stack core rss memlock maxproc maxfiles" -d Resource
complete -c launchctl -n __fish_use_subcommand -xa bsexec -d "Execute program in another context"
complete -c launchctl -n "__fish_seen_subcommand_from bsexec" -x -a "(__fish_complete_pids)"
complete -c launchctl -n __fish_use_subcommand -xa asuser -d "Execute program in a user's context"
complete -c launchctl -n "__fish_seen_subcommand_from asuser" -x -a "(__fish_complete_user_ids)"
complete -c launchctl -n __fish_use_subcommand -xa managerpid -d "Print PID of launchd controlling session"
complete -c launchctl -n __fish_use_subcommand -xa manageruid -d "Print UID of launchd session"
complete -c launchctl -n __fish_use_subcommand -xa managername -d "Print name of launchd session"
complete -c launchctl -n __fish_use_subcommand -xa help -d "Print subcommand usage"

# ----------------------------------------------------------------------------
# UNDOCUMENTED SUBCOMMANDS
# ----------------------------------------------------------------------------

complete -c launchctl -n __fish_use_subcommand -xa uncache -d "Remove a service from the cache"
complete -c launchctl -n __fish_use_subcommand -xa runstats -d "Get performance statistics"
complete -c launchctl -n __fish_use_subcommand -xa dumpstate -d "Dump launchd state to stdout"
complete -c launchctl -n __fish_use_subcommand -xa dumpjpcategory -d "Dump jetsam prop category for all services"
complete -c launchctl -n __fish_use_subcommand -xa bootshell -d "Bring up system from single-user mode"
