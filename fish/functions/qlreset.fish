function qlreset -d "Reset QuickLook"
    command -q qlmanage; or return 127
    qlmanage -r cache   # qlmanage: call reset on cache
    and qlmanage -r     # qlmanage: resetting quicklookd
    and killall quicklookd Dock Finder
end
