f()
{ #: - open a Finder/Explorer window for the current/specified directory
  local here="${@-.}"

  case $PLATFORM in
    mac)
      open -a Finder "$here"
      ;;
    windows)
      "$(cygpath --windir)/explorer" "$(cygpath -w "$here")"
      ;;
    *)
      scold 'not available on this system'
      return 71
      ;;
  esac
  return 0
}
