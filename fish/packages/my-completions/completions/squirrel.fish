# -n "__fish_seen_argument -s c -l clear"

set -l unverbose_flags_short V h
set -l unverbose_flags_long version help
set -l unverbose_flags -s$unverbose_flags_short -l$unverbose_flags_long
set -l no_unverbose_flags "not __fish_seen_argument $unverbose_flags"

set -l noop_flags_short i l q $unverbose_flags_short
set -l noop_flags_long info list query $unverbose_flags_long
set -l noop_flags -s$noop_flags_short -l$noop_flags_long
set -l no_noop_flags "not __fish_seen_argument $noop_flags"

set -l excl_mode_flags_short c C $noop_flags_short
set -l excl_mode_flags_long clear count $noop_flags_long
set -l excl_mode_flags -s$excl_mode_flags_short -l$excl_mode_flags_long
set -l no_mode_flags "not __fish_seen_argument $excl_mode_flags"

set -l echo_only_flags_short n $noop_flags_short
set -l echo_only_flags_long dry-run $noop_flags_long
set -l echo_only_flags -s$echo_only_flags_short -l$echo_only_flags_long
set -l no_echo_only_flags "not __fish_seen_argument $echo_only_flags"

set -l echo_flags_short C s v
set -l echo_flags_long count silent verbose
set -l echo_flags -s$echo_flags_short -l$echo_flags_long
set -l no_echo_flags "not __fish_seen_argument $echo_flags"

complete -c squirrel -s c -l clear -n $no_mode_flags -d "remove metadata"
complete -c squirrel -s i -l info -n $no_mode_flags -d "list layers and their status"
complete -c squirrel -s l -l list -n $no_mode_flags -d "only list layer names"
complete -c squirrel -s q -l query -n $no_mode_flags -d "return true if metadata flag set"
complete -c squirrel -s C -l count -n "$no_mode_flags; and $no_echo_flags" -d "only print ct. of archived layers"

complete -c squirrel -s f -l force -n $no_noop_flags -d "re-process even if metadata flag set"
complete -c squirrel -s n -l dry-run -n $no_noop_flags -d "only show what would be done"
complete -c squirrel -s s -l silent -n "$no_echo_flags; and $no_echo_only_flags" -d "no output (only exit code)"
complete -c squirrel -s v -l verbose -n "$no_echo_flags; and $no_unverbose_flags" -d "extra output"
complete -c squirrel -s V -l version -n "$no_mode_flags; and $no_echo_flags" -d "print version and exit"
complete -c squirrel -s h -l help -n "$no_mode_flags; and $no_echo_flags" -d "print help and exit"
