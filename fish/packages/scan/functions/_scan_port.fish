function _scan_port --description 'Track access on <port>' -a port
    sudo lsof -i :$port
end
