#!/usr/bin/env bash

#: - checks syntax of ~/.config/**/*.{bash,sh}
#: $ check_dotfiles [shellcheck_options]
#: < shellcheck

if ! type -P shellcheck >/dev/null; then
  echo >&2 "not found: shellcheck"
  exit 1
fi

# SC1090:   ignore non-constant sourcing
# ├─SC1091: don't follow sourced files
# ├─SC2034: don't flag "unused" variables
# └─SC2154: variable is referenced but not assigned
# SC2148:   don't require shebang
export SHELLCHECK_OPTS="$SHELLCHECK_OPTS -e SC1090,SC1091,SC2034,SC2154,SC2148"
if [[ $TERM_PROGRAM == "vscode" ]]; then
  export SHELLCHECK_OPTS="$SHELLCHECK_OPTS --color=never --format=gcc"
fi

main()
(
  local err=0
  _check_dotfiles_env "$@"  || ((err++))
  _check_dotfiles_sh "$@"   || ((err++))
  _check_dotfiles_bash "$@" || ((err++))
  return $(( err > 0 ))
)

_check_dotfiles_env()
{
  local syntax="sh"
  local -a files=("$XDG_CONFIG_HOME/environment.sh"
                  "$XDG_CONFIG_HOME/environment.d"/*.sh)
  local -a opts=("$@")
  shellcheck -s "$syntax" "${opts[@]}" "${files[@]}"
}

_check_dotfiles_sh()
{
  local syntax="sh"
  local -a files=("$XDG_CONFIG_HOME/sh"/**/*.sh)
  local -a opts=("$@")
  shellcheck -s "$syntax" "${opts[@]}" "${files[@]}"
}

_check_dotfiles_bash()
{
  local syntax="bash"
  local -a files=("$XDG_CONFIG_HOME/bash"/**/*.bash)
  local -a opts=("$@")
  shellcheck -s "$syntax" "${opts[@]}" "${files[@]}"
}

main "$@"
