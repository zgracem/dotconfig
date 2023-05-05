function xattrs -d "List all xattr names of a file"
    command xattr -l $argv[1] | string split -m1 -f1 ": "
end
