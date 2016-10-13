[[ $OSTYPE =~ darwin ]] || return

scan()
{
  local usage="${FUNCNAME[0]} ssh | wifi | file NAME | pid PID | port PORT"

  local verb=$1
  local noun=$2

  case $verb in
    ssh)
      # list all SSH-enabled hosts on the domain
      dns-sd -B _ssh._tcp
      ;;
    [Ww]i[Ff]i)
      # scan for WiFi networks
      "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport" -s
      ;;
    file)
      sudo opensnoop -v -f "${noun}"
      ;;
    pid)
      sudo opensnoop -v -p "${noun}"
      ;;
    port)
      sudo lsof -i ":${noun}"
      ;;
    *)
      scold "Usage: ${usage}"
      return 1
      ;;
  esac
}
