function fish_title_window --description 'Update the window title'
    set -q long_hostname
    or set -g long_hostname (prompt_hostname)
    or set -g long_hostname $hostname

    string match -q vscode "$TERM_PROGRAM"
    or printf "%s@%s: " $USER $long_hostname
    short_home $PWD
end
