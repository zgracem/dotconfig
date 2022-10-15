function problem --description 'Mark the last command as a TODO'
    set -l file $XDG_CONFIG_HOME/TODO.fish
    set -l prev (history -n1)
    string match -q "*$prev*" <$file; and return
    echo "# $prev" >>$file
end
