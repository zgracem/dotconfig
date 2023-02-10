function qlreset -d "Reset QuickLook"
    qlmanage -r cache   # qlmanage: call reset on cache
    and qlmanage -r     # qlmanage: resetting quicklookd
    and killall Finder  # kill -term ####
end
