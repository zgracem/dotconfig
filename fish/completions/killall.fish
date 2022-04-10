# macOS `killall`

if uname -s | string match -q Darwin
    function __fish_complete_ttys
        ps a -o tty | sed 1d | uniq
    end

    function __fish_complete_process_names
        set -l re '^\s*\d+\) "([^"\(]+).*".+'
        lsappinfo list | string match -rg $re | sort -u | while read -l proc
            string trim -r $proc
        end
    end

    complete -c killall --erase

    complete -c killall -n "__fish_is_nth_token 1" -xa "(__fish_complete_process_names)"
    complete -c killall -o help -n "__fish_is_nth_token 1" -d "Print help and exit"
    complete -c killall -s l -n "__fish_is_nth_token 1" -d "List signals and exit"
    complete -c killall -s s -d "Simulate only, send no signal"
    complete -c killall -s d -d "Print detailed info about process, send no signal"
    complete -c killall -s v -d "Be more verbose"
    complete -c killall -s z -d "Do not skip zombies"
    complete -c killall -s m -d "Match PROCNAME as a regex"
    complete -c killall -s u -xa "(__fish_complete_users)" -d "Limit processes to USER's"
    complete -c killall -s e -n "__fish_seen_argument -s u" -d "Use EUID, not real UID"
    complete -c killall -s t -xa "(__fish_complete_ttys)" -d "Limit processes to TTY's"
    complete -c killall -s c -n "__fish_seen_argument -s u -s t" -xa "(__fish_complete_process_names)" -d "Further limit by PROCNAME"

    # Programmatically add flags like -HUP, -INT, -QUIT
    killall -l | string split -n " " | cat -n | while read -l sig_no sig_name
        complete -c killall -o $sig_no -d "$sig_name"
    end
end
