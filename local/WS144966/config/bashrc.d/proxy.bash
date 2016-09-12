if [[ -z $Z_IN_BASHRC ]]; then
  echo >&2 "${BASH_SOURCE[0]} called"
fi

. ~/.local/config/bashrc.d/private.proxy.bash
