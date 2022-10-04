function manpdf --description 'View a manual page as PDF'
    # https://github.com/zgracem/manpdf
    in-path manpdf; or return 127

    set -l pdf (command manpdf -f $argv)
    or return

    if string match -q "/*" "$pdf"
        echo "$pdf"
        not set -q SSH_CONNECTION; and open "$pdf"
    end
end
