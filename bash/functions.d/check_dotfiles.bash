check_dotfiles()
{ #: - checks syntax of ~/.config/**/*.{bash,sh}
  #: $ check_dotfiles [shellcheck_options]
  #: < shellcheck
  #
  # SC2034 = don't flag "unused" variables (OK)
  # SC2154 = variable is referenced but not assigned (OK)
  # SC2155 = don't require shebang
  local SHELLCHECK_OPTS="$SHELLCHECK_OPTS -e SC2034,SC2154,SC2155"
  shellcheck -s sh "$@" "$XDG_CONFIG_HOME/environment.sh" "$XDG_CONFIG_HOME/environment.d"/*.sh
  shellcheck -s sh "$@" "$XDG_CONFIG_HOME/sh"/**/*.sh
  # SC2207 = prefer mapfile to split output (TODO: fix)
  shellcheck -s bash -e SC2207 "$@" "$XDG_CONFIG_HOME/bash"/**/*.bash
}
