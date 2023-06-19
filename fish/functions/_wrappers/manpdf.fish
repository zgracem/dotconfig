function manpdf --description 'View a manual page as PDF'
    set -l pdf (command manpdf $argv)
    or return

    if string match -q "/*" $pdf
        echo $pdf
        set -q SSH_CONNECTION; or open $pdf
    end
end
