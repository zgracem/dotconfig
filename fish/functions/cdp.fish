function cdp -a dir -d "cd, but resolve symlinks"
    if fish-is-older-than 3.5
        cd (builtin realpath $dir)
    else
        cd (path resolve $dir)
    end
end

# When `~/.config` is a symlink to `~/Dropbox/.config`...
#   bash:
#     ~/.config $ cd -L ..
#     ~ $
#     ~/.config $ cd -P ..
#     ~/Dropbox $
#   fish:
#     ~/.config > cd ..
#     ~ >
#     ~/.config > cdp ..
#     ~/Dropbox >
