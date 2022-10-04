function httpserve --description 'Start an HTTP server in the current directory'
    echo "Starting server at http://localhost:8888 ..."
    ruby -run -e httpd -- --port 8888 .
end
