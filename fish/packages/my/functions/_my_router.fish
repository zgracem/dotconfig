function _my_router --description 'Display current router address'
    if is-cygwin
        ipconfig | string replace -fr '.*Default Gateway.*: ([\d.]+).*' '$1'
    else if in-path netstat
        netstat -rn | string replace -fr '^(?:default|0\.0\.0\.0) +([\d.]+).*$' '$1'
    end
end
