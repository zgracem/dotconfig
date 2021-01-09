function unique --description "Prints only unique values"
    set --local seen
    for arg in $argv
        contains -- $arg $seen; or set --append seen $arg
    end
    echo -ns $seen\n
end
