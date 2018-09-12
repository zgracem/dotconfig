if _inPath shellcheck; then
  export SHELLCHECK_OPTS="-x -e SC2155 -e SC2034"
  # -x = source external files
  # -e SC2155 = don't require shebang
  # -e SC2034 = don't flag "unused" variables
fi
