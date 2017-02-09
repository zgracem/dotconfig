canon()
{ #: - get canonical path to $1 (or PWD)
  #: * doesn't always resolve symlinks properly on Cygwin
  local input=${1-$PWD}
  local dirname=$input

  if [[ -f $input ]]; then
    local basename=${input##*/} dirname=${input%/*}
    if [[ -z $dirname || $input == $dirname ]]; then
      dirname=.
    fi
  fi

  if [[ -d $dirname ]]; then
    local canon_dir
    if canon_dir=$(builtin cd "$dirname" 2>/dev/null && pwd -P); then
      printf "%s\n" "${canon_dir}${basename:+/$basename}"
      return
    fi
  fi

  scold "$input: could not canonicalize"
  return 66
}
