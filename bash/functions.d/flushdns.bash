[[ $OSTYPE =~ (darwin|cygwin) ]] || return

flushdns()
{
  case $OSTYPE in
    darwin*)
      # This doesn't work on versions of OS X with that discoveryd(?) mess,
      # but hopefully I'll never need to use that again.
      dscacheutil -flushcache \
        && killall -HUP mDNSResponder &>/dev/null
      ;;
    cygwin)
      $(cygpath -au "$SYSTEMROOT\System32\ipconfig.exe") /flushdns
      # `ipconfig /?` gives really good documentation, incidentally.
      ;;
  esac
}
