function pdfgrep -d "Search PDFs with ripgrep"
    set -p argv --pre=pre-rg --pre-glob="*.pdf"
    set -p argv --type-add="pdf:*.pdf" --type=pdf
    command rg $argv
end
