set -q __z_env_loaded; and exit

# XDG Basedir Spec
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/var/cache
set -gx XDG_RUNTIME_DIR ~/var/run

set -q TMPDIR; or set -gx TMPDIR (dirname (mktemp -u))

# If the current user's group doesn't own TMPDIR, check to see if it's mounted
# "noexec" (as it would be on a shared host) and change to a path under HOME.
if not path is --perm=group $TMPDIR; and mount | grep -q " on $TMPDIR.*noexec,"
    set -gx TMPDIR $XDG_RUNTIME_DIR
    mkdir -p $TMPDIR
end

for env_file in $__fish_config_dir/__env/*.fish
    . $env_file
end

set -g __z_env_loaded (date +"%F %T")
