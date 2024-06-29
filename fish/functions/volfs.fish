function volfs -d "Convert paths to and from volfs format"
    command -q GetFileInfo; or return
    for path in $argv
        if string match -q "/.vol/*" $path
            GetFileInfo $path 2>/dev/null \
            | string match -rg '(?<=(?:file|directory): )"(.+)"'
        else
            /usr/bin/stat -f "/.vol/%d/%i" $path
        end
    end
end
