function ql -d "Preview with QuickLook"
    command -q qlmanage; or return 127
    argparse r/reset -- $argv; or return

    if set -q _flag_reset[1]
        qlmanage -r cache   # qlmanage: call reset on cache
        and qlmanage -r     # qlmanage: resetting quicklookd
        and killall quicklookd Dock Finder
    else if set -q argv[1]
        qlmanage -p >/dev/null 2>&1 $argv[1]
    else
        return 2
    end
end
