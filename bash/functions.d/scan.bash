[[ $PLATFORM == mac ]] || return

scan()
{ #: - scans for various information (macOS only)
  #: $ scan ssh | wifi | file <name> | pid <id> | port <port>
  #: | ssh         = list all SSH-enabled hosts on the current domain
  #: | wifi        = list all public SSIDs
  #: | file <name> = tracks access to NAME
  #: | pid <id>    = tracks access by process ID
  #: | port <port> = tracks access on PORT

  local verb=$1
  local noun=$2

  case $verb in
    ssh)
      dns-sd -B _ssh._tcp
      ;;
    [Ww]i[Ff]i)
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
      fdoc_usage
      return 64
      ;;
  esac
}
