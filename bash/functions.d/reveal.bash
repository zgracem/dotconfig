reveal()
{ # reveal $1 in Finder/Explorer
  if (( $# == 1 )); then
    local target="$1"        
  else
    return 1
  fi

  case $OSTYPE in
    darwin*)
      open -R "$target"
      ;;
    cygwin)
      "$(cygpath --windir)/explorer" /select, "$(cygpath -w "$target")"
      # cygstart --explore "$(dirname "$target")"
      ;;
    *)
      scold 'not available on this system'
      return 1
      ;;
  esac
}
