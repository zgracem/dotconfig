abbr --erase killall
functions --erase killall
function killall --description 'Kill processes by name'
    set --local errors 0

    function _killall_valid_pid
        command ps -p $argv[1] >/dev/null
    end

    for proc in $argv
        string match -q --regex "^--?(?=\S)" -- $proc; and continue
        set --local pids (command ps -s | command grep -w $proc | awk '{print $1}')

        for pid in $pids
            if string match --quiet --regex '^\d+$' $pid
                if /bin/kill --force -SIGTERM $pid
                    sleep 0.2
                    if _killall_valid_pid $pid
                        /bin/kill --force -9 $pid; or set errors (math $errors + 1)
                        sleep 0.2
                        if _killall_valid_pid $pid
                            echo >&2 "error: couldn't kill PID ($pid) for process '$proc'"
                            set errors (math $errors + 1)
                        end
                    end
                else
                    echo >&2 "error: invalid PID ($pid) for process '$proc'"
                    set errors (math $errors + 1)
                end
            else
                echo >&2 "error: process not found: $proc"
                set errors (math $errors + 1)
            end
        end
    end

    # return $errors
    test $errors -eq 0
end
