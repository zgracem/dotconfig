if in-path rbenv
    test -d $HOME/.rbenv; or mkdir $HOME/.rbenv
    test -f $HOME/.rbenv/version; or rbenv global system
    source (rbenv init - | psub) # adds duplicate shims dir to PATH
end
