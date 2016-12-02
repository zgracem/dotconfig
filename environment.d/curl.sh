CURL_HOME=$XDG_CONFIG_HOME/curl

if [ -f "$CURL_HOME/.curlrc" ]; then
  export CURL_HOME
else
  unset -v CURL_HOME
fi
