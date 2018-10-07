start_proxy()
{ # open an SSH tunnel for use as a SOCKS5 proxy
  local addr="127.0.0.1"
  local port="8080"

  ssh -fqN -D "$port" -o "ExitOnForwardFailure=yes" "$@" || return
  #    │││  │          └─ wait until tunnel is established before going to background
  #    │││  └──────────── dynamic port forwarding on 8080
  #    ││└─────────────── don't execute remote command (forward only)
  #    │└──────────────── quiet mode
  #    └───────────────── go to background

  export SOCKS5_SERVER="${addr}:${port}"
  export ALL_PROXY="socks5h://${SOCKS5_SERVER}"
}
