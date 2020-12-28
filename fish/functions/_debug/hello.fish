function hello --description 'Say hello'
    set -q argv[1]; or set -l argv[1] world
    echo "Hello, "$argv"!"
end
