function manpdf --description 'View a manual page as PDF'
    # https://github.com/zgracem/manpdf
    in-path manpdf; or return 127

    set -lx MANPDF_DIR "$XDG_DATA_HOME/doc/pdf"

    set -l pdf (command manpdf -f $argv); or return
    if string match -q "/*" "$pdf"
        echo "$pdf"

        if not set -q SSH_CONNECTION
            open "$pdf"
        end
    end
end
