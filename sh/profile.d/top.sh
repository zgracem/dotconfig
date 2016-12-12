top()
{
  set -- -F -R -u "$@"
  #       │  │  └── sort by CPU usage and execution time
  #       │  └───── don't traverse/report memory object map for each process
  #       └──────── ignore frameworks

  set -- -user "$USER" "$@"
  #       └──────── only processes owned by current user

  command top "$@"
}

