# pmset

function __fish_complete_pmset_settings
    argparse (fish_opt --short=u) -- $argv

    set -l settings \
        'displaysleep,Display sleep timer' \
        'disksleep,Disk spindown timer' \
        'sleep,System sleep timer' \
        'womp,Wake on ethernet magic packet' \
        'ring,Wake on modem ring' \
        'powernap,Enable/disable Power Nap' \
        'proximitywake,Control system wake based on proximity of iCloud devices' \
        'autorestart,Automatic restart on power loss' \
        'lidwake,Wake the machine when the laptop lid is opened' \
        'acwake,Wake the machine when power source is changed' \
        'lessbright,Turn down display brightness when switching to this power source' \
        'halfdim,Use a half-brightness state between full and fully off ' \
        'sms,Use Sudden Motion Sensor to park disk heads' \
        'hibernatemode,Change hibernation mode' \
        'hibernatefile,Change hibernation image file location' \
        'ttyskeepawake,Prevent idle system sleep when any tty is "active"' \
        'destroyfvkeyonstandby,Destroy FileVault key when going to standby mode'

    if set -q _flag_u
        set -a settings \
            'haltlevel,Battery level at which to trigger emergency shutdown' \
            'haltafter,Duration in minutes after which to trigger emergency shutdown' \
            'haltremain,Minutes remaining in battery at which to trigger emergency shutdown'
    end

    for setting in $settings
        echo -e (string replace ',' '\t' $setting)
    end
end

function __fish_complete_pmset_getting
    set -l gettings \
        'live,Display the settings currently in use' \
        'custom,Display custom settings for all power sources' \
        'cap,Display which power management features the machine supports' \
        'sched,Display scheduled startup/wake and shutdown/sleep events' \
        'ups,Display UPS emergency thresholds' \
        'ps,Display status of batteries and UPSs' \
        'batt,Display status of batteries and UPSs' \
        'pslog,Display an ongoing log of power source state' \
        'rawlog,Display an ongoing log of battery state read directly from battery' \
        'thermlog,Display a log of thermal notifications that affect CPU speed' \
        'assertions,Display a summary of power assertions' \
        'assertionslog,Display a log of assertion creations and releases' \
        'activity,Display a summary of power state of Display wrangler and Disk Queue Manager' \
        'activitylog,Display a log of power state changes to Display Wrangler and Disk Queue Manager' \
        'sysload,Display the system load advisory' \
        'sysloadlog,Display an ongoing log of lives changes to the system load advisory' \
        'ac,Display details about an attached AC power adapter' \
        'adapter,Display details about an attached AC power adapter' \
        'log,Display a history of sleeps, wakes, and other power management events' \
        'uuid,Display the currently active sleep/wake UUID' \
        'uuidlog,Display the active sleep/wake UUID, and new UUIDs as set by the system' \
        'history,Display a timeline of system sleeplwake UUIDs' \
        'historydetailed,Display driver-level timings for a sleep/wake' \
        'powerstate,Print the current power states for I/O Kit drivers' \
        'powerstatelog,Periodically print power state residency times for some drivers' \
        'stats,Print number of sleeps and wakes since last boot' \
        'systemstate,Print the current power state and capabilities of the system' \
        'everything,Print everything'

    for getting in $gettings
        echo -e (string replace ',' '\t' $getting)
    end
end

function __fish_complete_pmset_moreargs
    set -l args \
        'boot,Tell the kernel that system boot is complete' \
        'force,Tell PM to immediately activate these settings' \
        'touch,PM re-reads existing settings from disk' \
        'noidle,Create an assertion to prevent idle sleep' \
        'sleepnow,Cause an immediate system sleep' \
        'resetdisplayambientparams,Reset ambient light parameters' \
        'schedule,Set up a one-time power event' \
        'repeat,Set up a recurring power event'

    for arg in $args
        echo -e (string replace ',' '\t' $arg)
    end
end

complete -c pmset --no-files
complete -c pmset -a "(__fish_complete_pmset_settings; __fish_complete_pmset_moreargs)"
complete -c pmset -s a -x -a "(__fish_complete_pmset_settings)" -d 'Apply settings to all'
complete -c pmset -s b -x -a "(__fish_complete_pmset_settings)" -d 'Apply settings to battery'
complete -c pmset -s c -x -a "(__fish_complete_pmset_settings)" -d 'Apply settings to charger'
complete -c pmset -s u -x -a "(__fish_complete_pmset_settings -u)" -d 'Apply settings to UPS'
complete -c pmset -s g -x -a "(__fish_complete_pmset_getting)" -d 'Display current settings'
