in-path qlmanage; or return

function ql -d "Preview with QuickLook"
    qlmanage -p >/dev/null 2>&1 $argv
end
