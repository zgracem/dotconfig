function __fish_describe_function -d "Return a function's description, if any"
    functions -Dv $argv[1] | string join0 | string split0 -f5
end
