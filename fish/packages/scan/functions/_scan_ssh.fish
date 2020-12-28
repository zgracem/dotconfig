function _scan_ssh --description 'List all SSH-enabled hosts on the current domain'
    dns-sd -B _ssh._tcp
end
