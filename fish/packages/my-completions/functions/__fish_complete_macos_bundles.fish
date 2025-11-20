# Based on $__fish_data_dir/completions/open.fish
function __fish_complete_macos_bundles
    set -l application_list (
        mdfind -onlyin /Applications -onlyin ~/Applications \
            -onlyin /System/Applications -onlyin /Developer/Applications \
            'kMDItemContentType==com.apple.application-*'
    )
    mdls $application_list -name kMDItemCFBundleIdentifier \
        | string replace -rf 'kMDItemCFBundleIdentifier = "(.+)"' '$1'
end
