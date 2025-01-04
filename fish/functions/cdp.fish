function cdp -a dir -d "cd, but resolve symlinks"
    if fish-is-older-than 3.6 # released Jan 2023
        cd (command realpath $dir)
    else
        cd (path resolve $dir)
    end
end
