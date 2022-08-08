set -l tbcopy_desc "Read to clipboard and write to standard output"

if command -sq pbcopy
    function tbcopy -d $tbcopy_desc
        set -l tmpfile (gmktemp -t tbcopy.XXXXXXXX); or return
        cat >$tmpfile
        pbcopy <$tmpfile
        cat $tmpfile
    end
else if path is -w /dev/clipboard
    function tbcopy -d $tbcopy_desc
        tee /dev/clipboard
    end
end
