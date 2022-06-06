function un1q -d "Delete duplicate, nonconsecutive lines from stdin"
    cat | sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'
end
