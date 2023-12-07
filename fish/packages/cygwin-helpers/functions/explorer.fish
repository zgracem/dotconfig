function explorer -d "Open Windows Explorer"
    set -l windir (cygpath --windir)
    "$windir/explorer" $argv
end
