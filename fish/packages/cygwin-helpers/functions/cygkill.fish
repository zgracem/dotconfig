function cygkill -d "Kill a process by its Windows PID"
    /bin/kill --force -SIGTERM $argv
    #           └──────── use Win32 interface
end
