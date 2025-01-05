function imggrep -d "Search images (slowly) with ripgrep"
    for cmd in rg pre-rg ocr-cli; command -q $cmd; or return 127; end
    set -p argv --pre=pre-rg --pre-glob="*.{jpg,gif,png}"
    set -p argv --type-add=img:*.{jpg,gif,png} --type=img

    command rg $argv
end
