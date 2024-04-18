#!/usr/bin/env bash

# This script is called by a Makefile and will install Homebrew on either an
# Intel or M* machine, unless it's already installed.

: "${DRY_RUN:=true}"
DIR="$(dirname "$(readlink -e "$0")")"

case "$(/usr/bin/uname -a)" in
  CYGWIN*)
    echo "Not compatible with this system!" >&2
    exit 1
    ;;
  *arm64*)
    HOMEBREW_REPO=/opt/homebrew
    ;;
  *x86_64*)
    if [[ "$(sysctl -in sysctl.proc_translated)" == 1 ]]; then
      HOMEBREW_REPO=/opt/homebrew
    else
      HOMEBREW_REPO=/usr/local/Homebrew
    fi
    ;;
esac

# If not writing to a terminal, just echo the Homebrew path and quit.
# That way we can access HOMEBREW_REPO easily from inside the Makefile.
if [[ $1 == --repo ]] || [[ ! -t 1 ]]; then
  echo "$HOMEBREW_REPO"
  exit
fi

if [[ "$DRY_RUN" != false ]]; then
  echo "\`export DRY_RUN=false\` before running this script to actually install Homebrew." >&2
fi

function install_homebrew() {
  if [[ -d $HOMEBREW_REPO ]]; then
    echo "Homebrew already installed!" >&2
    return
  else
    if [[ "$DRY_RUN" != false ]]; then
      echo "[DRY_RUN=$DRY_RUN] Installing Homebrew..."
      return
    else
      # one-liner from https://brew.sh/
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  fi
}

install_homebrew || exit

# Required by Makefiles
required_pkgs=(bash coreutils)
for pkg in "${required_pkgs[@]}"; do
  if [[ "$DRY_RUN" != false ]]; then
    echo "[DRY_RUN=$DRY_RUN] brew install $pkg..."
  elif [[ -x $HOMEBREW_REPO/../Cellar/$pkg ]]; then
    echo "$pkg already installed!"
  else
    brew install "$pkg"
  fi
done
