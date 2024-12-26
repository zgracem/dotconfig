function fish_title_tab --description 'Update the tab title'
    set -l cwd (short_home $PWD)
    set -l cwd_parts (string split "/" "$cwd")
    set -l ellipsis "…"

    # use Windows-1252 encoding, or taskbar will have "â€¦" instead of dots
    is-cygwin; and set ellipsis (echo -ne "\x85")

    echo -ns (prompt_hostname) ":"

    if test (count $cwd_parts) -le 2
        echo -n $cwd
    else
        string join / -- $cwd_parts[1] $ellipsis $cwd_parts[-1]
    end
end
