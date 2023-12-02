if is-cygwin
    abbr --erase killall
    functions --erase killall
    function killall --description 'Kill processes by name'
        set --local errors 0

        function _pgrep
            command ps -s | command grep -w $argv[1] | awk '{print $1}'
        end
        function _pgrep-q
            command ps -p $argv[1] >/dev/null
        end
        function _kill
            /bin/kill --force $argv
        end

        for proc in $argv
            string match -q --regex "^--?(?=\S)" -- $proc; and continue
            set --local pids (_pgrep $proc)

            for pid in $pids
                if string match --quiet --regex '^\d+$' $pid
                    if _kill -SIGTERM $pid
                        sleep 0.2
                        if _pgrep-q $pid
                            _kill -9 $pid; or set errors (math $errors + 1)
                            sleep 0.2
                            if _pgrep-q $pid
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
end
