if fish-is-older-than 2.4
    function in-path
        for exe in $argv
            command -v $exe 2>&1 >/dev/null
            or return
        end
        return 0
    end
else
    function in-path --description 'Exits 0 if all arguments are available in PATH'
        for exe in $argv
            command -v -q $exe
            or return
        end
        return 0
    end
end
