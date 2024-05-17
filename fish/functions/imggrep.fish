function imggrep -d "Search images (slowly) with ripgrep"
    command -q rg; or return 127
    set -p argv --pre=pre-rg --pre-glob="*.{jpg,gif,png}"
    set -p argv --type-add=img:*.{jpg,gif,png} --type=img

    command rg $argv
end
