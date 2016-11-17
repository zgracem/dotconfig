whichpkg()
{ # find the Cygwin/Homebrew package to which file $1 belongs

  if (( $# == 1 )); then
    local file="$1"
  else
    scold "Usage: $FUNCNAME file"
    return 1
  fi

  if [[ $file != */* ]]; then
    # Search the current directory
    if [[ -f $PWD/$file ]]; then
      file="$PWD/$file"
    # Search for an executable in PATH
    elif file=$(type -P "$file"); then
      : # Do nothing, we're fine
    else
      scold "not found: $1"
      return 1
    fi
  fi

  # canonicalize 
  local canon
  if [[ $OSTYPE == darwin* ]]; then
    canon=$(mdutil -t "$file")
    if [[ $canon != /* ]]; then
      scold "$file: could not canonicalize"
      return 1
    fi
  elif ! canon=$(readlink -e "$file"); then
    scold "$file: could not canonicalize"
    return 1
  fi

  if [[ $OSTYPE == cygwin ]]; then
    local mgr="Cygwin"
    local pkg=$(cygcheck --find-package "$canon")
  elif [[ -d $HOMEBREW_PREFIX ]]; then
    local mgr="Homebrew"
    [[ $OSTYPE == linux* ]] && mgr="Linuxbrew"

    local regex="^$HOMEBREW_PREFIX/Cellar/([^/]+)/([^/]+)/.+\$"
    if [[ $canon =~ $regex ]]; then
      local pkg="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"
    fi 
  else
    scold "no compatible package manager found"
    return 1
  fi

  if [[ -n $pkg ]]; then
    printf '%s\n' "$pkg"
  else
    scold "$file: does not seem to belong to a $mgr package"
    return 1
  fi
}
