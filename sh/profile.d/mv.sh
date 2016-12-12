mv()
{
  set -- -iv "$@"
  #       │└─ verbose
  #       └── interactive

  if [ "$PLATFORM" = "mac" ]; then
    # >> http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    /bin/mv "$@"
  else
    command mv "$@"
  fi
}
