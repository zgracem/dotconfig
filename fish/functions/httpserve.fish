function httpserve --description "Start an HTTP server in the current directory"
    if set -q argv[1]
        set -f port $argv[1]
    else
        set -f port 8888
    end
    set -l url "http://localhost:$port"
    echo "Starting server at $url ..."
    ruby -run -e httpd -- --port $port .
end
