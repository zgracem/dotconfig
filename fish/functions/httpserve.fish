function httpserve --description 'Start an HTTP server in the current directory'
    ruby -run -e httpd -- --port 8888 .
end
