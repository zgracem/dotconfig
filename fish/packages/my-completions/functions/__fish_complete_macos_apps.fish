# Based on $__fish_data_dir/completions/open.fish
function __fish_complete_macos_apps
    mdfind -onlyin /Applications -onlyin ~/Applications \
        -onlyin /System/Applications -onlyin /Developer/Applications \
        'kMDItemContentType==com.apple.application-*' \
    | string replace -r '.+/(.+).app' '$1' \
    | sort -u
end
