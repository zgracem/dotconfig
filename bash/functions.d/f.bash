f()
{ #: - open a Finder/Explorer window for $PWD/$1
  local here="${*-.}"

  case $PLATFORM in
    mac)
      open -a Finder "$here"
      ;;
    windows)
      "$(cygpath --windir)/explorer" "$(cygpath -w "$here")"
      ;;
    *)
      echo >&2 'not available on this system'
      return 1
      ;;
  esac
  return 0
}
