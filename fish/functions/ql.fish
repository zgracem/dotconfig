function ql -d "Preview with QuickLook"
    command -q qlmanage; or return 127
    qlmanage -p >/dev/null 2>&1 $argv
end
