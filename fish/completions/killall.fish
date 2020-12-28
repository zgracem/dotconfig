# macOS `killall`

if uname -s | string match -q Darwin
    function __fish_complete_ttys
        ps a -o tty | sed 1d | uniq
    end

    complete -c killall --erase

    complete -c killall -s v -d 'Be more verbose'
    complete -c killall -o help -d 'Print help and exit'
    complete -c killall -s l -d 'List signals and exit'
    complete -c killall -s m -x -d 'Match PROCNAME as a regex'
    complete -c killall -s s -d 'Simulate only, send no signal'
    complete -c killall -s d -d 'Print detailed info about process, send no signal'
    complete -c killall -s u -xa "(__fish_complete_users)" -d 'Limit processes to USER\'s'
    complete -c killall -s e -n '__fish_seen_argument -s u' -d 'Use effective UID, not real UID'
    complete -c killall -s t -xa "(__fish_complete_ttys)" -d 'Limit processes to TTY\'s'
    complete -c killall -s c -n '__fish_seen_argument -s u; or __fish_seen_argument -s t' -x -d 'Limit processes further to match'
    complete -c killall -s z -d 'Do not skip zombies'

    killall -l | string split -n " " | cat -n | while read -l sig_no sig_name
        complete -c killall -o $sig_no -d "$sig_name"
    end
end
