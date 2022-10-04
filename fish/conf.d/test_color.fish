function test_color
    set -l params (string join \; $argv)
    set -l message " Hello, world! "
    echo -es "|\e[" $params m $message "\e[0m|"
end
