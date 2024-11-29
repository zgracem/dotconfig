# See ~/.config/env.d/term.env
function term_href -a uri text id
    if not set -q uri[1] text[1]
        echo >&2 Usage: (status function) URI TEXT [ID]
        return 1
    end
    # set -l encoded_uri (string escape --style=url $uri)

    echo -nes $OSC "8;" id=$id ";$uri" $ST
    set_color --underline blue
    echo -ne $text
    set_color normal
    echo -es $OSC "8;;" $ST
end
