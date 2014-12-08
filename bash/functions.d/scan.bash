[[ $OSTYPE =~ darwin ]] || return

# TODO: turn into shell script
scan()
{

    declare usage="$FUNCNAME ssh | wifi | file NAME"
    case $1 in
        ssh) # list all SSH-enabled hosts on the domain
            /usr/bin/dns-sd -B _ssh._tcp
            ;;
        [Ww]i[Ff]i) # scan for WiFi networks
            /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s
            ;;
        file)
            sudo opensnoop -f "$2"
            ;;
        *)
            scold "Usage: %s" "$usage"
            return 1
            ;;
    esac
}
