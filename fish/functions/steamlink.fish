function steamlink -d "Launch Steam Link in windowed mode"
    is-macos; or return 127
    open -a "Steam Link" --args --windowed $argv
end
