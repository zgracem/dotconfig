function imggrep -d "Search images (slowly) with ripgrep"
    command rg --type=img --pre=--pre=pre-rg $argv
end
