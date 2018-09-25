webshare()
{ #: - share PWD at localhost:17777 (or port specified at $1)
  #: > https://github.com/mathiasbynens/dotfiles/blob/bceb49d/.functions#L79
  local port="${1:-17777}"

  # Set default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}
