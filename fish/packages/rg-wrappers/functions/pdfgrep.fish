function pdfgrep -d "Search PDFs with ripgrep"
    command rg --type=pdf --pre=pre-rg $argv
end
