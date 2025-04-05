if fish-is-older-than 3.5 # released June 2022
    function path
        string match -rq '^(?:is|filter)' $argv[1]; or return 127
        set --erase argv[1]
        string match -q -- "-*" $argv[1]; or return 127
        set -l switch $argv[1]
        set --erase argv[1]
        for arg in $argv
            if test $switch $arg
                echo $arg
            else
                false
            end
        end
    end
end
