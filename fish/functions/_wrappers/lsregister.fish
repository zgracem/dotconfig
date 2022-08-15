is-macos; or exit

function lsregister --description 'Manage the Launch Services database'
    set -l PATH $PATH
    set -p PATH /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support
    command lsregister $argv
end
