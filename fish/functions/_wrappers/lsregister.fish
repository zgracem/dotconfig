is-macos; or exit

function lsregister --description 'Manage the Launch Services database'
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister $argv
end
