function in-path --description 'Exits 0 if all arguments are available in PATH'
    for exe in $argv
        command -s -q $exe
        or return
    end
    return 0
end
