# pmset

function __fish_complete_pmset_settings
  set -l settings \
    'displaysleep\tDisplay sleep timer' \
    'disksleep\tDisk spindown timer' \
    'sleep\tSystem sleep timer' \
    'womp\tWake on ethernet magic packet' \
    'ring\tWake on modem ring' \
    'powernap\tEnable/disable Power Nap' \
    'proximitywake\tControl system wake based on proximity of iCloud devices' \
    'autorestart\tAutomatic restart on power loss' \
    'lidwake\tWake the machine when the laptop lid is opened' \
    'acwake\tWake the machine when power source is changed' \
    'lessbright\tTurn down display brightness when switching to this power source' \
    'halfdim\tUse a half-brightness state between full and fully off ' \
    'sms\tUse Sudden Motion Sensor to park disk heads' \
    'hibernatemode\tChange hibernation mode' \
    'hibernatefile\tChange hibernation image file location' \
    'ttyskeepawake\tPrevent idle system sleep when any tty is "active"' \
    'destroyfvkeyonstandby\tDestroy FileVault key when going to standby mode'

  if test "$argv[1]" = "-u"
    set -a settings \
      'haltlevel\tBattery level at which to trigger emergency shutdown' \
      'haltafter\tDuration in minutes after which to trigger emergency shutdown' \
      'haltremain\tMinutes remaining in battery at which to trigger emergency shutdown'
  end

  for setting in $settings
    echo -e $setting
  end
end

function __fish_complete_pmset_getting
  set -l gettings \
    'live\tDisplay the settings currently in use' \
    'custom\tDisplay custom settings for all power sources' \
    'cap\tDisplay which power management features the machine supports' \
    'sched\tDisplay scheduled startup/wake and shutdown/sleep events' \
    'ups\tDisplay UPS emergency thresholds' \
    'ps\tDisplay status of batteries and UPSs' \
    'batt\tDisplay status of batteries and UPSs' \
    'pslog\tDisplay an ongoing log of power source state' \
    'rawlog\tDisplay an ongoing log of battery state read directly from battery' \
    'thermlog\tDisplay a log of thermal notifications that affect CPU speed' \
    'assertions\tDisplay a summary of power assertions' \
    'assertionslog\tDisplay a log of assertion creations and releases' \
    'activity\tDisplay a summary of power state of Display wrangler and Disk Queue Manager' \
    'activitylog\tDisplay a log of power state changes to Display Wrangler and Disk Queue Manager' \
    'sysload\tDisplay the system load advisory' \
    'sysloadlog\tDisplay an ongoing log of lives changes to the system load advisory' \
    'ac\tDisplay details about an attached AC power adapter' \
    'adapter\tDisplay details about an attached AC power adapter' \
    'log\tDisplay a history of sleeps, wakes, and other power management events' \
    'uuid\tDisplay the currently active sleep/wake UUID' \
    'uuidlog\tDisplay the active sleep/wake UUID, and new UUIDs as set by the system' \
    'history\tDisplay a timeline of system sleeplwake UUIDs' \
    'historydetailed\tDisplay driver-level timings for a sleep/wake' \
    'powerstate\tPrint the current power states for I/O Kit drivers' \
    'powerstatelog\tPeriodically print power state residency times for some drivers' \
    'stats\tPrint number of sleeps and wakes since last boot' \
    'systemstate\tPrint the current power state and capabilities of the system' \
    'everything\tPrint everything'

  for getting in $gettings
    echo -e $getting
  end
end

function __fish_complete_pmset_moreargs
  set -l args \
    'boot\tTell the kernel that system boot is complete' \
    'force\tTell PM to immediately activate these settings' \
    'touch\tPM re-reads existing settings from disk' \
    'noidle\tCreate an assertion to prevent idle sleep' \
    'sleepnow\tCause an immediate system sleep' \
    'resetdisplayambientparams\tReset ambient light parameters' \
    'schedule\tSet up a one-time power event' \
    'repeat\tSet up a recurring power event'

  for arg in $args
    echo -e $arg
  end
end

complete -c pmset -a "(__fish_complete_pmset_settings; __fish_complete_pmset_moreargs)"
complete -c pmset -s a -x -a "(__fish_complete_pmset_settings)" -d 'Apply settings to all'
complete -c pmset -s b -x -a "(__fish_complete_pmset_settings)" -d 'Apply settings to battery'
complete -c pmset -s c -x -a "(__fish_complete_pmset_settings)" -d 'Apply settings to charger'
complete -c pmset -s u -x -a "(__fish_complete_pmset_settings -u)" -d 'Apply settings to UPS'
complete -c pmset -s g -x -d 'Display current settings'
complete -c pmset -s g -a "(__fish_complete_pmset_getting)"
