check_dotfiles()
( #: - checks syntax of ~/.config/**/*.{bash,sh}
  #: $ check_dotfiles [shellcheck_options]
  #: < shellcheck
  #
  # SC1091: don't follow sourced files (OK)
  # SC2034: don't flag "unused" variables (OK)
  # SC2148: don't require shebang (OK)
  # SC2154: variable is referenced but not assigned (OK)
  local err=0
  export SHELLCHECK_OPTS="$SHELLCHECK_OPTS -e SC1091,SC2034,SC2148,SC2154"
  _z_check_dotfiles_env "$@"  || ((err++))
  _z_check_dotfiles_sh "$@"   || ((err++))
  _z_check_dotfiles_bash "$@" || ((err++))
  return $(( err > 0 ))
)

_z_check_dotfiles_env()
{
  local syntax="sh"
  local -a files=("$XDG_CONFIG_HOME/environment.sh"
                  "$XDG_CONFIG_HOME/environment.d"/*.sh)
  shellcheck -s "$syntax" "$@" "${files[@]}"
}

_z_check_dotfiles_sh()
{
  local syntax="sh"
  local -a files=("$XDG_CONFIG_HOME/sh"/**/*.sh)
  shellcheck -s "$syntax" "$@" "${files[@]}"
}

_z_check_dotfiles_bash()
{
  local syntax="bash"
  local -a files=("$XDG_CONFIG_HOME/bash"/**/*.bash)
  shellcheck -s "$syntax" "$@" "${files[@]}"
}
