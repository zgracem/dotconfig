#!/usr/bin/env bash

#: - checks syntax of ~/.config/**/*.{bash,sh}
#: $ check_dotfiles [shellcheck_options]
#: < shellcheck

if ! type -P shellcheck >/dev/null; then
  echo >&2 "not found: shellcheck"
  exit 1
fi

if [[ $TERM_PROGRAM == "vscode" ]]; then
  export SHELLCHECK_OPTS="$SHELLCHECK_OPTS --color=never --format=gcc"
fi

main()
(
  local err=0
  _check_dotfiles_sh "$@"   || ((err++))
  _check_dotfiles_bash "$@" || ((err++))
  return $(( err > 0 ))
)

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
