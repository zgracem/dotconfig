[[ $PLATFORM == windows ]] || return

cyglink()
{ #: - creates a directory junction (helpful when running w/out admin rights)
  #: $ cyglink <target> <link>
  #: * inverts the syntax of Windows' `MKLINK` for consistency with e.g. ln(1)

  if (( $# == 0 )); then
    fdoc_usage >&2
    return 64
  else
    local target="$1"
    local link="$2"
  fi

  if [[ ! -d $target ]]; then
    scold "not a directory: $target"
    return 65
  fi

  cmd /C mklink /J "$(cygpath -aw "$link")" "$(cygpath -aw "$target")"
}
