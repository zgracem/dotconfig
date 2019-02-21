reveal()
{ #: - reveal $1 in Finder/Explorer
  local target="${1?}"

  case $PLATFORM in
    mac)
      open -R "$target"
      ;;
    windows)
      "$(cygpath --windir)/explorer" /select, "$(cygpath -w "$target")"
      ;;
    *)
      scold 'not available on this system'
      return 1
      ;;
  esac
}
