function hlep -d "Pretty-prints --help output"
    $argv[1] --help 2>&1 | bat -pp -l help
end
