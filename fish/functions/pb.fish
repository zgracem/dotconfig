function pb
    # Usage: pb sort -u
    #        # = pbpaste | sort -u | pbcopy
    #        pb "tr -d '\"' | sort | uniq -c"
    #        # = pbpaste | tr -d '"' | sort | uniq -c | pbcopy
    eval "pbpaste | $argv | tbcopy"
end
