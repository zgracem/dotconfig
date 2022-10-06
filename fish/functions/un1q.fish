in-path un1q; and exit

function un1q -d "Delete duplicate, nonconsecutive lines from stdin"
    cat | sed -nf $XDG_CONFIG_HOME/bin/shims/un1q
end
