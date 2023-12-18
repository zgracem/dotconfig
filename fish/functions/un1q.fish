# Because this function is called by $__fish_config_dir/config.fish and some
# $__fish_config_dir/conf.d/*.fish files, it must be located in a default path
# for functions.
in-path un1q; and exit

function un1q -d "Delete duplicate, nonconsecutive lines from stdin"
    cat | sed -nf $HOME/.config/bin/un1q
end
