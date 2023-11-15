function pdfgrep -d "Search PDFs with ripgrep"
    command rg --type=pdf --pre=$XDG_CONFIG_HOME/libexec/pre-rg.fish $argv
end
