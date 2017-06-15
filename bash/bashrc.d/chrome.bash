# Google Chrome
# Check proxy settings at: chrome://net-internals/#proxy

export flags_chrome=()

if [[ -n $SOCKS5_SERVER ]]; then
  flags_chrome+=('--host-resolver-rules="MAP * ~NOTFOUND, EXCLUDE '"${SOCKS5_SERVER%:*}"'"')
  flags_chrome+=('--proxy-server="socks5://'"${SOCKS5_SERVER}"'"')
  flags_chrome+=('--proxy-bypass-list="<local>;'"${SOCKS5_SERVER%:*}"';"')
  flags_chrome+=('--disable-background-mode')
  flags_chrome+=('--disable-background-networking')
  flags_chrome+=('--dns-prefetch-disable')
  # flags_chrome+=('--disable-remote-fonts')
fi
