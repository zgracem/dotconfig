function pdfgrep -d "Search PDFs with ripgrep"
    for cmd in rg pre-rg pdftotext; command -q $cmd; or return 127; end
    set -p argv --pre=pre-rg --pre-glob="*.pdf"
    set -p argv --type-add="pdf:*.pdf" --type=pdf
    command rg $argv
end
