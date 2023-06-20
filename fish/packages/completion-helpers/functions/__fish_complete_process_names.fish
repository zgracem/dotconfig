function __fish_complete_process_names
    killall -dm '.' | string match -rg '\bcmd:(.+?)(?=, pid:\d)' | path sort -u
end
