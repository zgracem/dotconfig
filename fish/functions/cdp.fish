function cdp -a dir -d "cd, but resolve symlinks"
    if fish-is-older-than 3.6
        cd (command realpath $dir)
    else
        cd (path resolve $dir)
    end
end
