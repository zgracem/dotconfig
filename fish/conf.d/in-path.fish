if fish-is-older-than 2.4
    function in-path
        command -v $argv 2>&1 >/dev/null
    end
else
    function in-path --description 'Exits 0 if all arguments are available in PATH'
        command -v -q $argv
    end
end
