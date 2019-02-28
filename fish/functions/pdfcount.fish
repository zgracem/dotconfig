function pdfcount --description 'Count PDF pages in the current directory'
  for pdf in *.pdf
    printf "%s\\t%s\n" "$pdf" (qpdf --show-npages "$pdf")
  end
end
