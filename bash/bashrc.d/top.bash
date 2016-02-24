top()
{
    command top -F -R -u -user "$USER" "$@"
    #            │  │  │  └─────────────── only processes owned by current user
    #            │  │  └────────────────── sort by CPU usage and execution time
    #            │  └───────────────────── don't traverse/report memory object map for each process
    #            └──────────────────────── ignore frameworks
}
