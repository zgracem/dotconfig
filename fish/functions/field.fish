function field -d "Display the nth element from stdin" -a num
    set -q num; or return 1
    cat | string join0 | string split0 --fields=$num
end
