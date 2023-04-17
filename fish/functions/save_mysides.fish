function save_mysides
    begin
        echo -n '['
        mysides list | while read line
            printf '{"name":"%s","path":"%s"},' (string split -- " -> " $line)
        end | head -c-1
        echo -n ']'
    end | tee $XDG_CONFIG_HOME/macos/mysides.json
end
