[[ $OSTYPE == cygwin ]] && [[ -x $COMSPEC ]] || return

cyglink()
{
  # Creates a directory junction. (Helpful when running w/out admin rights.)
  # NOTE: This function inverts the syntax of Windows' internal `MKLINK`
  # command for consistency with e.g. ln(1).

  if (( $# == 0 )); then
    scold "Usage: $FUNCNAME target link"
    return 1
  else
    local target="$1"
    local link="$2"
  fi

  if [[ ! -d $target ]]; then
    scold "not a directory: $target"
    return 1
  fi

  "$COMSPEC" /C mklink /J "$(cygpath -aw "$link")" "$(cygpath -aw "$target")"
}
