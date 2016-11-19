whichpkg()
{ # Find the package to which file $1 belongs

  if (( $# == 1 )); then
    local file="$1"
  else
    scold "Usage: $FUNCNAME file"
    return 1
  fi

  local pkg

  if [[ $file != */* ]]; then
    if [[ -f $PWD/$file ]]        # Search the current directory
    then
      file="$PWD/$file"
    elif file=$(type -P "$file")  # Search for an executable in PATH
    then
      file="$file"
    elif [[ -n $HOMEBREW_PREFIX ]] \
        && pkg=$(brew which-formula "$1" 2>/dev/null) \
        && [[ -n $pkg ]]          # Search using homebrew-command-not-found
    then
      printf "%s (not installed)\n" "$pkg"
      return 0
    else
      scold "not found: $1"
      return 1
    fi
  fi

  # Resolve symlinks to determine canonical filename
  local canon
  if [[ $OSTYPE == darwin* ]]; then
    canon=$(mdutil -t "$file")
    if [[ $canon != /* ]]; then
      scold "$file: could not canonicalize"
      return 1
    fi
  else
    if ! canon=$(readlink -e "$file"); then
      scold "$file: could not canonicalize"
      return 1
    fi
  fi

  # Homebrew/Linuxbrew
  if command -v brew >/dev/null; then
    local mgr="Homebrew"
    [[ $OSTYPE == *linux* ]] && mgr="Linuxbrew"

    local regex="^$(brew --cellar)/([^/]+)/([^/]+)/.+\$"
    if [[ $canon =~ $regex ]]; then
      local pkg="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"
    fi

  # Cygwin
  elif command -v cygcheck >/dev/null; then
    local mgr="Cygwin"
    local pkg=$(cygcheck --find-package "$canon")

  # Pacman (Arch Linux/MSYS2)
  elif command -v pacman >/dev/null; then
    local mgr="Pacman"
    local pkg=$(pacman --query --owns "$canon")
    pkg=${pkg#* is owned by }

  else
    scold "no compatible package manager found"
    return 1
  fi

  if [[ -n $pkg ]]; then
    printf "%s\n" "$pkg"
  else
    scold "$file: does not seem to belong to a $mgr package"
    return 1
  fi
}
