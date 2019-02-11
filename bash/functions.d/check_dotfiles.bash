_inPath shellcheck || return

check_dotfiles()
( #: - checks syntax of ~/.config/**/*.{bash,sh}
  #: $ check_dotfiles [shellcheck_options]
  #: < shellcheck
  #
  # SC1090:   ignore non-constant sourcing (OK)
  # ├─SC1091: don't follow sourced files (OK)
  # ├─SC2034: don't flag "unused" variables (OK)
  # └─SC2154: variable is referenced but not assigned (OK)
  # SC2148:   don't require shebang (OK)
  local err=0
  export SHELLCHECK_OPTS="$SHELLCHECK_OPTS -e SC1090,SC1091,SC2034,SC2154,SC2148"
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
  local -a opts=("$@")
  shellcheck -s "$syntax" "${opts[@]}" "${files[@]}"
}

_z_check_dotfiles_sh()
{
  local syntax="sh"
  local -a files=("$XDG_CONFIG_HOME/sh"/**/*.sh)
  local -a opts=("$@")
  shellcheck -s "$syntax" "${opts[@]}" "${files[@]}"
}

_z_check_dotfiles_bash()
{
  local syntax="bash"
  local -a files=("$XDG_CONFIG_HOME/bash"/**/*.bash)
  local -a opts=("$@")
  shellcheck -s "$syntax" "${opts[@]}" "${files[@]}"
}
