function smbdo
    set -l cmd "$argv"
    set -l server "//CRYPT/WFW311"

    smbclient -N -c $cmd $server
end
