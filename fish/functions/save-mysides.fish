function save-mysides
    set -l json_file $XDG_CONFIG_HOME/macos/mysides.json
    set -l temp_file (mktemp -t mysides.XXXXXX); or return

    begin
        echo -n '['
        mysides list | while read line
            printf '{"name":"%s","path":"%s"},' (string split -- " -> " $line)
        end | head -c-1
        echo -n ']'
    end > $temp_file
    or return

    command mv -f $temp_file $json_file
end
