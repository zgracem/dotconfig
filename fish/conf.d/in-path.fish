if fish-is-newer-than 2.3
    function in-path --description 'Exits 0 if all arguments are available in PATH'
        command -v -q $argv
    end
else
    function in-path
        command -v $argv 2>&1 >/dev/null
    end
end
