function update-xscreensaver
    set -l actual_file ~/.xscreensaver
    set -l config_dir ~/src/github.com/zgracem/dotconfig
    set -l config_file $config_dir/.xscreensaver

    confupdate
    or return

    if test $actual_file -nt $config_file
        echo "~/.xscreensaver is newer"
        cp -afv $actual_file $config_file
        and git -C $config_dir add $config_file
        and git -C $config_dir commit -m "xscreensaver: update settings"
        and git -C $config_dir push
    else
        echo "…/dotconfig/.xscreensaver is newer"
        cp -afv $config_file $actual_file
    end
end
