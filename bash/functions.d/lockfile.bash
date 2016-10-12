lockfile()
{
  case $OSTYPE in
    darwin*)
      sudo chflags uchg "$@"
      ;;
    cygwin)
      "${SYSTEMROOT}/system32/attrib" +R "$@"
      ;;
    *)
      scold 'not available on this system'
      return 1
      ;;
  esac

  chmod a-w "$@"
}

unlockfile()
{
  case $OSTYPE in
    darwin*)
      sudo chflags nouchg "$@"
      ;;
    cygwin)
      "${SYSTEMROOT}/system32/attrib" +R "$@"
      ;;
    *)
      scold 'not available on this system'
      return 1
      ;;
  esac

  chmod u+w "$@"
}
