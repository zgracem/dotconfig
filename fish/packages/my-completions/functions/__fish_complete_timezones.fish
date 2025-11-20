function __fish_complete_timezones
    set -l zone_dir /usr/share/zoneinfo
    string match -rg "^$zone_dir/([^+][^.]+)" $zone_dir/**
end
