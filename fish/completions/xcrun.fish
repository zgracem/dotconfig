# xcrun (macOS)

function __fish_complete_xcrun_sdks
    xcodebuild -showsdks | string replace -f -r -- '^\s+(.+?)\s+-sdk (.+)$' '$2'\t'$1'
end

complete -c xcrun -s v -l verbose -d 'Add verbose information'
complete -c xcrun -s n -l no-cache -d "Skip (and refresh) cache"
complete -c xcrun -s k -l kill-cache -d 'Remove the cache'
complete -c xcrun -l sdk -x -a "(__fish_complete_xcrun_sdks)" -d 'Specify SDK to search for tools'
complete -c xcrun -l toolchain -d 'Specify toolchain'
complete -c xcrun -s l -l log -d 'Print full command line'
complete -c xcrun -s f -l find -d 'Print resolved tool path instead of executing'
complete -c xcrun -s r -l run -d 'Execute resolved tool path'
complete -c xcrun -l show-sdk-path -d 'Print SDK path'
complete -c xcrun -l show-sdk-version -d 'Print SDK version number'
complete -c xcrun -l show-sdk-build-version -d 'Print SDK build version number'
complete -c xcrun -l show-sdk-platform-path -d 'Print SDK platform path'
complete -c xcrun -l show-sdk-platform-version -d 'Print SDK platform version number'
