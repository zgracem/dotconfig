function _my_router --description 'Display current router address'
    if is-cygwin
        ipconfig | string match -rg '.*Default Gateway.*: ([\d.]+).*'
    else if in-path netstat
        netstat -rn | string match -rg '^(?:default|0\.0\.0\.0) +([\d.]+).*$'
    end
end
