# RBENV_ROOT set in ~/.config/env.d/rbenv.env
if path is -d $RBENV_ROOT; and command -q rbenv
    # first line sets PATH; redundant w/ paths.fish
    source (rbenv init - fish | tail -n+2 | psub)

    set -l rbenv_version_file $RBENV_ROOT/version

    path is -f $rbenv_version_file
    or rbenv global >$rbenv_version_file

    read -gx GLOBAL_RBENV_VERSION <$rbenv_version_file
end
