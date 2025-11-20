function __fish_complete_signals
    __fish_make_completion_signals
    set -l signals (string split -f2 " " $__kill_signals)
    echo -ns $signals\tsignal\n
end
