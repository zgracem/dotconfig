[[ $OSTYPE =~ darwin ]] || return

scan()
{
    local usage="${FUNCNAME[0]} ssh | wifi | file NAME | pid PID"

    case $1 in
        ssh)
            # list all SSH-enabled hosts on the domain
            dns-sd -B _ssh._tcp
            ;;
        [Ww]i[Ff]i)
            # scan for WiFi networks
            airport -s
            ;;
        file)
            sudo opensnoop -v -f "$2"
            ;;
        pid)
            sudo opensnoop -v -p "$2"
            ;;
        *)
            scold "Usage: ${usage}"
            return $EX_USAGE
            ;;
    esac
}
