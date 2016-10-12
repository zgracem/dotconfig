xtrace()
{
  if [[ :$SHELLOPTS: =~ :xtrace: ]]; then
    # turn it off
    set +o xtrace
  else
    set -o xtrace
  fi
}
