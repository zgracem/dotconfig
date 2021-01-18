if set -gxq __z_env_loaded
    echo >&2 "tried to reload environment from $__z_env_loaded -- aborting"
    exit
end

# XDG Basedir Spec
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/var/cache"
export XDG_RUNTIME_DIR="$HOME/var/run"

test -z "$TMPDIR"; or set -gx TMPDIR (dirname (mktemp -u))

# If the current user's group doesn't own TMPDIR, check to see if it's mounted
# "noexec" (as it would be on a shared host) and change to a path under HOME.
if not test -G $TMPDIR; and mount | grep -q " on $TMPDIR.*noexec,"
    set -gx TMPDIR $XDG_RUNTIME_DIR
    mkdir -p $TMPDIR
end

set -gx PLATFORM unknown
switch (uname -s)
    case "*_NT-*"
        set PLATFORM windows
    case Darwin
        set PLATFORM mac
    case Linux
        set PLATFORM linux
end

for env_file in $__fish_config_dir/__env/*.fish
    . $env_file
end

# API tokens
for token_file in ~/.private/tokens/*
    read -gx (basename $token_file) <$token_file
end

set -gx __z_env_loaded (date +"%F %T")
