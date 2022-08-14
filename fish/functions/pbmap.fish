function pbmap -d "Modify the clipboard in place"
    # Usage: pbmap sort -u
    #        # = pbpaste | sort -u | pbcopy
    #        pbmap "tr -d '\"' | sort | uniq -c"
    #        # = pbpaste | tr -d '"' | sort | uniq -c | pbcopy
    eval "pbpaste | $argv | tbcopy"
end
