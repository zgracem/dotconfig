set -q __z_env_loaded; and exit

set -q TMPDIR; or set -gx TMPDIR (dirname (mktemp -u))

# If the current user's group doesn't own TMPDIR, check to see if it's mounted
# "noexec" (as it would be on a shared host) and change to a path under HOME.
if not test -G "$TMPDIR"; and mount | grep -q " on $TMPDIR.*noexec,"
    set -gx TMPDIR $HOME/var/run
    mkdir -p $TMPDIR
end

# setup PATH and friends
source "$__fish_config_dir/paths.fish"

for env_file in $XDG_CONFIG_HOME/env.d/*.env $__fish_config_dir/env.d/*.fish
    source $env_file
end

set -g __z_env_loaded (date +"%F %T")
