fish-is-older-than 3.6; or exit

function cdp -a dir -d "cd, but resolve symlinks"
    cd (command realpath $dir)
end
