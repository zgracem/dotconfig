function manpath -d "determine search path for manual pages"
    # When MANPATH is set and /usr/local/etc/man_db.conf exists,
    # manpath(1) will emit a warning about the redundant configuration.
    # The `-q` switch silences these warnings.
    set -p argv -q
    command manpath $argv
end
