function prune -d "Delete broken symlinks in PWD"
    find -L . -name . -o -type d -prune -o -type l -exec rm -v {} +
end
