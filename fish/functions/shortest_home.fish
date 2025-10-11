function shortest_home -d 'Replace $HOME with ~ in a path'
    set -l cwd (short_home $argv[1])
    set -l ellipsis "…"
    is-cygwin; and set ellipsis (echo -ne "\x85")

    set -l cwd_parts (string split "/" "$cwd")
    if test (count $cwd_parts) -le 2
        echo -n $cwd
    else
        echo -n (string join / -- $cwd_parts[1] $ellipsis $cwd_parts[-1])
    end
end
