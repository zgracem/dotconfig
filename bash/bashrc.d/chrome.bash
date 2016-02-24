# Google Chrome
# Check proxy settings at: chrome://net-internals/#proxy

export flags_chrome=()

flags_chrome+=('--allow-file-access')
flags_chrome+=('--allow-file-access-from-files')

if [[ -n $SOCKS5_SERVER ]]; then
    flags_chrome+=("--proxy-server=\"socks5://${SOCKS5_SERVER}\"")
    flags_chrome+=('--proxy-bypass-list="localhost;127.0.0.1"')
    flags_chrome+=('--disable-background-mode')
    flags_chrome+=('--disable-background-networking')
    flags_chrome+=('--dns-prefetch-disable')
    flags_chrome+=('--host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE 127.0.0.1"')
    # flags_chrome+=('--disable-remote-fonts')
fi
