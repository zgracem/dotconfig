#!/usr/bin/env fish

# Execute this script to build a spoofed user-agent string, based on the current
# version of Google Chrome.

function get-chrome-version -a chrome_path
    if path is -x $chrome_path
        set -l chrome_path_escaped (string escape -- $chrome_path)
        set -l chrome_version (eval "$chrome_path_escaped --version"); or exit
        if test -n "$chrome_version"
            printf "%s" (string trim $chrome_version)
        else
            printf >&2 "failure in %s\n" (status function)
            exit 1
        end
    else
        printf >&2 "failure in %s: Chrome not found at %s\n" (status function) $chrome_path
        exit 1
    end
end

function get-chrome-version-macos
    set -l chrome_cask "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask/Casks/google-chrome.rb"
    if not path is -f $chrome_cask
        printf >&2 "failure in %s: file not found at %s\n" (status function) $chrome_cask
        exit 1
    end
    gsed -nE 's/^\s+version "([0-9.]+).*"/\1/p' $chrome_cask
end

function get-chrome-version-linux
    get-chrome-version "/usr/bin/chromium-browser"
end

function get-chrome-version-windows
    for dir in 'C:\\Program Files (x86)' "$LOCALAPPDATA"
        set -g chrome_path "$dir\\Google\\Chrome\\Application\\chrome.exe"
        if path is -f (cygpath -au "$chrome_path")
            break
        else
            set --erase chrome_path
        end
    end

    if set -q chrome_path
        if command -sq wmic
            set -l chrome_path_escaped (string escape -- $chrome_path)
            wmic datafile where "name=\"$chrome_path_escaped\"" get Version /value
        else
            get-chrome-version "$chrome_path"
        end
    end
end

function print-user-agent
    set -g webkit_version "537.36"

    switch (uname -s)
        case 'Darwin'
            set -l macos_ver (sw_vers -productVersion); or return 1
            set -g system_id "Macintosh; Intel Mac OS X "(string replace -a . _ $macos_ver)
            set -g chrome_version (get-chrome-version-macos)
        case 'Linux' '*BSD'
            set -g system_id 'X11; '(uname -s)' '(uname -m); or return 1
            set -g chrome_version (get-chrome-version-linux)
        case 'CYGWIN*' 'MSYS*'
            set -l win_ver (uname -s | string replace -rf '.*_NT-([\d.]+).*' '$1'); or return 1
            set -g system_id "Windows NT $win_ver; Win64; x64"
            set -g chrome_version (get-chrome-version-windows)
    end

    set -l fmt "Mozilla/5.0 (%s) AppleWebKit/%.2f (KHTML, like Gecko) Chrome/%s Safari/%.2f"
    printf "$fmt\n" $system_id $webkit_version $chrome_version $webkit_version
end

print-user-agent
