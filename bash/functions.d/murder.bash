return # TODO: finish this

# Goal: send 15 (which `killall` does by default on macOS), wait a few seconds,
# then try 2, and if that doesn't work, try 1; if THAT doesn't work, use 9.

murder()
{
    # This could be a number, in which case it's a PID (*nix or Cygwin tho?), or
    # a name, either one macOS's `killall` will accept (e.g. "Finder") or
    # a complete process name (`pgrep -x`)
    local victim="$1"

    if [[ $victim =~ ^[[:digit:]]$ ]]; then
        # This is a PID. 
    fi

    # `kill` is sometimes a builtin (so per-shell behaviour), and sometimes
    # /bin/kill (so at least separate GNU/BSD behaviour), and then sometimes
    # we're on Windows+Cygwin, god help us

    if [[ $OSTYPE =~ darwin ]]; then
        kill
    fi
}
