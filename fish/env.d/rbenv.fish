# RBENV_ROOT set in paths.fish
if path is -d $RBENV_ROOT; and in-path rbenv
    source (rbenv init - | psub) # adds duplicate shims dir to PATH

    set -l rbenv_version_file $RBENV_ROOT/version

    path is -f $rbenv_version_file
    or rbenv global >$rbenv_version_file

    read -gx GLOBAL_RBENV_VERSION <$rbenv_version_file
end
