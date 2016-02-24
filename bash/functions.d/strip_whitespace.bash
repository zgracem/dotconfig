strip_whitespace()
{   # http://mywiki.wooledge.org/BashFAQ/067
    
    #   $ x=" hello world  "; echo "/${x}/" # => / hello world  /
    #   $ strip_whitespace x; echo "/${x}/" # => /hello world/

    if [[ -n ${!1} ]]; then
        read -rd '' $1 <<< "${!1}"
    fi
}
