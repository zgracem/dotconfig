function dosbox
    set -l opts
    set -a opts -conf $XDG_CONFIG_HOME/dosbox-x/dosbox-x.conf
    set -a opts -display2 amber
    dosbox-x $opts $argv
end
