function xattrs -d "List all xattr names of a file"
    command -q xattr; or return 127
    command xattr -l $argv[1] | string split -m1 -f1 ": "
end
