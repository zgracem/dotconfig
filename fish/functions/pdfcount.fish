function pdfcount --description 'Count PDF pages in the current directory'
    if not command -sq qpdf
        echo >&2 "error: not found: qpdf"
        return 127
    end

    for pdf in *.pdf
        printf "%s\\t%s\n" "$pdf" (qpdf --show-npages "$pdf")
    end
end
