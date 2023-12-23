# macOS `killall`

if uname -s | string match -q Darwin
    function __fish_complete_process_names
        killall -dm '.' | string match -rg '\bcmd:(.+?)(?=, pid:\d)' | path sort -u
    end

    function __fish_complete_ttys
        ps a -o tty | tail -n+2 | path sort -u
    end

    complete -c killall --erase

    complete -c killall -n "__fish_is_first_token" -xa "(__fish_complete_process_names)"
    complete -c killall -s d -d "Print diagnostics, send no signal"
    complete -c killall -s e -n "__fish_seen_argument -s u" -d "Use EUID, not real UID"
    complete -c killall -o help -n "__fish_is_first_token" -d "Print help and exit"
    complete -c killall -s l -n "__fish_is_first_token" -d "List signals and exit"
    complete -c killall -s m -d "Match PROCNAME as regex"
    complete -c killall -s v -d "Be verbose"
    complete -c killall -s s -d "Simulate only, send no signal"
    complete -c killall -s u -xa "(__fish_complete_users)" -d "Limit processes to USER's"
    complete -c killall -s t -xa "(__fish_complete_ttys)" -d "Limit processes to TTY's"
    complete -c killall -s c -n "__fish_seen_argument -s u -s t" -xa "(__fish_complete_process_names)" -d "Further limit by PROCNAME"
    complete -c killall -s q -d "Suppress error if no processes match"
    complete -c killall -s z -d "Do not skip zombies"

    # Programmatically add flags like -HUP, -INT, -QUIT
    killall -l | string split -n " " | cat -n | string upper \
    | while read -l sig_no sig_name
        complete -c killall -o $sig_no -o SIG$sig_name -d "$sig_name"
    end
end
