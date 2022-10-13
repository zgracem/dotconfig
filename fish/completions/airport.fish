exit # broken

function __fish_complete_airport_interfaces
    set -l interfaces (echo list | scutil \
        | string match -rg "Setup:/Network/Interface/(en\d)/AirPort")

    echo -ns $interfaces\tInterface\n
end

function __fish_complete_airport_verbs
    set -l verbs \
        "prefs,Display preferences" \
        "logger,Monitor the logging facility" \
        "sniff,Begin sniffing 802.11 frames" \
        "debug,Enable debug logging"

    string replace , \t $verbs
end

function __fish_complete_boolean -a comp
    set -l bools YES NO
    echo -ns $bools\n | string match -e "$comp"
end

function __fish_complete_airport_prefs_set
    set -l boolean_prefs \
        DisconnectOnLogout \
        RememberRecentNetworks \
        RequireAdmin \
        RequireAdminIBSS \
        RequireAdminNetworkChange \
        RequireAdminPowerToggle \
        AllowLegacyNetworks \
        WoWEnabled

    set -l string_prefs \
        JoinMode \
        JoinModeFallback

    set -l token (commandline -ct)
    set -l pref (string split -f1 = $token)
    set -l value (string split -f2 = $token)
    switch $token
    case "*=*"
        switch $pref
        case $boolean_prefs
            set -f comps $pref=(__fish_complete_boolean $value)\t
        case JoinMode
            set -l values Automatic Preferred Ranked Recent Strongest
            set -f comps $pref=(string match -e "$value" $values)\t
        case JoinModeFallback
            set -l values Prompt JoinOpen KeepLooking DoNothing
            set -f comps $pref=(string match -e "$value" $values)\t
        end
    case "*"
        set -f comps (string match -e "$token" (__fish_complete_airport_prefs))
    case ""
        set -f comps (__fish_complete_airport_prefs)
    end

    if set -q comps[1]
        printf "%s\n" $comps
    end
end

function __fish_complete_airport_prefs
    printf "%s\tBoolean\n" $boolean_prefs
    printf "%s\tString\n" $string_prefs
end

function __fish_complete_airport_subcommand
    __fish_use_subcommand
    or not __fish_seen_subcommand_from prefs logger sniff debug
end

function __fish_complete_airport_debug
end

function __fish_complete_airport_channels
end

complete -c airport -n __fish_use_subcommand -xa "(__fish_complete_airport_interfaces)"
complete -c airport -n __fish_complete_airport_subcommand -xa "(__fish_complete_airport_verbs)"
complete -c airport -n "__fish_seen_subcommand_from prefs" -xa "(__fish_complete_airport_prefs_set)"
complete -c airport -n "__fish_seen_subcommand_from debug" -xa "(__fish_complete_airport_debug)"
complete -c airport -n "__fish_seen_subcommand_from sniff" -xa "(__fish_complete_airport_channels)"

complete -c airport -s c -l channel -n __fish_is_first_arg -xa "(__fish_complete_airport_channels)"
complete -c airport -s z -l disassociate -n __fish_is_first_arg -d "Disassociate from any network"
complete -c airport -s I -l getinfo -n __fish_is_first_arg -d "Print current wireless status"
complete -c airport -s s -l scan -n __fish_is_first_arg -x -d "Perform a wireless broadcast scan"
complete -c airport -s x -l xml -d "Print info as XML"
complete -c airport -s P -l psk -d "Create PSK"
complete -c airport -l password -n "__fish_seen_argument -s p -l psk" -x -d "Specify WPA Password"
complete -c airport -l ssid -n "__fish_seen_argument -s p -l psk" -x -d "Specify SSID for PSK"
complete -c airport -s h -l help -d "Show help"
