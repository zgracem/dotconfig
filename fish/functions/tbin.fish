function tbin -d "Send standard input to termbin.com"
    set -f temp_file (mktemp)
    or return

    cat >$temp_file
    set -f url (nc termbin.com 9999 <$temp_file)
    or return

    if set -q url[1]
        echo $url[1]
        echo -n $url[1] | pbcopy
        rm -f $temp_file
    end
end
