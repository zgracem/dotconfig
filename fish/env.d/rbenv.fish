if path is -d $RBENV_ROOT
    in-path rbenv; and source (rbenv init - | psub) # adds duplicate shims dir to PATH
end
