if not builtin -q path
    function path -a subcmd
        if string match -q is $subcmd
            test $argv[2..-1]
        else
            return 127
        end
    end
end
