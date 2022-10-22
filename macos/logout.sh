#!/usr/bin/env bash

exec >>~/var/log/logout.log 2>&1

export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# $XDG_RUNTIME_DIR defines the base directory relative to which user-specific
# non-essential runtime files and other file objects (such as sockets, named
# pipes, ...) should be stored.
export XDG_RUNTIME_DIR=$HOME/var/run

# The lifetime of the directory MUST be bound to the user being logged in.
# It MUST be created when the user first logs in; and if the user fully logs
# out, the directory MUST be removed.
if [[ -d $XDG_RUNTIME_DIR ]]; then
    # Files in the directory MUST not survive reboot or a full logout/login.
    rm -rf "$XDG_RUNTIME_DIR"
fi

# Create empty directory for next login
mkdir -p "$XDG_RUNTIME_DIR"
