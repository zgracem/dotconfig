function fish-is-newer-than -a test_version
    function __fish_versinfo -a fish_ver
        set -l version_info (string split "." "$fish_ver" | string split "-")

        set -q version_info[2]; or set version_info[2] 0
        set -q version_info[3]; or set version_info[3] 0
        set -q version_info[4]; or set version_info[4] 0

        string join \n $version_info
    end

    set -l this_ver (__fish_versinfo $version)
    set -l that_ver (__fish_versinfo $test_version)

    string match -q unknown "$version"; and return 0

    string match -q "$this_ver" "$that_ver"; and return 1

    for level in 1 2 3 4
        test "$this_ver[$level]" -gt "$that_ver[$level]"; and return 0
        test "$this_ver[$level]" -lt "$that_ver[$level]"; and return 1
    end

    return 0
end
