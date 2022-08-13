if _isGNU rm; then
  rm()
  {
    command rm -Iv "$@"
  }
else
  rm()
  {
    command rm -iv "$@"
    #           │└─ verbose
    #           └── interactive
  }
fi
