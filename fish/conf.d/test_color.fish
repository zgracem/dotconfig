# Usage: test_color "05;38;5;9"
#        test_color 05 38 5 9
function test_color
    set -l params (string join \; $argv)
    set -l message " Hello, world! "
    echo -es "|\e[" $params m $message "\e[0m|"
end
