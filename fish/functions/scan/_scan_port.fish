function _scan_port -a port --description 'Track access on <port>'
  sudo lsof -i :$port
end
