if in-path rbenv
    test -d $HOME/.rbenv; or mkdir $HOME/.rbenv
    test -f $HOME/.rbenv/version; or rbenv global system

    set -l plugin_dir $HOME/.rbenv/plugins/rbenv-default-gems
    if test ! -d $plugin_dir
        set -l plugin_git https://github.com/rbenv/rbenv-default-gems.git
        git clone $plugin_git $plugin_dir
    end

    if test ! -L $HOME/.rbenv/default-gems
        ln -sf $XDG_CONFIG_HOME/rbenv/default-gems $HOME/.rbenv/default-gems
    end

    source (rbenv init - | psub) # adds duplicate shims dir to PATH
end
