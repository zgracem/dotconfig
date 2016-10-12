hidefile()
{
  case $OSTYPE in
    darwin*)
      chflags hidden "$@"
      ;;
    cygwin)
      "${SYSTEMROOT}/system32/attrib" +H "$@"
      ;;
    *)
      scold "not available on this system"
      return 1
      ;;
  esac
}

unhidefile()
{
  case $OSTYPE in
    darwin*)
      chflags nohidden "$@"
      ;;
    cygwin)
      "${SYSTEMROOT}/system32/attrib" -H "$@"
      ;;
    *)
      scold "not available on this system"
      return 1
      ;;
  esac
}
