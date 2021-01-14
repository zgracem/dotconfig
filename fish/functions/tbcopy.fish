if in-path pbcopy
    function tbcopy
        set -l tmpfile (gmktemp -t tbcopy.XXXXXXXX); or return
        cat >$tmpfile
        pbcopy <$tmpfile
        cat $tmpfile
    end
else if test -w /dev/clipboard
    function tbcopy
        tee /dev/clipboard
    end
end
