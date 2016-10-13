reveal()
{ # reveal $1 in Finder/Explorer
  local target="${1?}"

  case $OSTYPE in
    darwin*)
      open -R "$target"
      ;;
    cygwin)
      "$(cygpath --windir)/explorer" /select, "$(cygpath -w "$target")"
      ;;
    *)
      scold 'not available on this system'
      return 1
      ;;
  esac
}
