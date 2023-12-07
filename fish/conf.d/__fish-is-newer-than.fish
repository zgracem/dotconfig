function fish-is-newer-than -a test_version
    # This function splits fish's `$version` into an array like BASH_VERSINFO.
    # Released fish versions are in the format `X.Y.Z` (even X.0.0 and X.Y.0).
    # Dev build versions are `X.Y.Z-A-gH`, where `X.Y.Z` is the last release,
    # `A` is the count of commits since x.y.z, `g` is literally the letter g,
    # and `H` is the shortened hash of the latest git commit (which we discard).
    function __fish_versinfo -a fish_ver
        # Account for broken builds and assume they're bleeding-edge
        string match -q unknown "$version"; and return 0

        set -l version_info (string split "." "$fish_ver" | string split "-")

        # The following allows for usage like `fish-is-newer-than 3.1`
        # (i.e. without the trailing `.0`) and for comparing releases to
        # development builds.
        set -q version_info[2]; or set version_info[2] 0
        set -q version_info[3]; or set version_info[3] 0
        set -q version_info[4]; or set version_info[4] 0

        string join \n $version_info
    end

    set -l this_ver (__fish_versinfo $version)
    set -l that_ver (__fish_versinfo $test_version)
    functions --erase __fish_versinfo

    # Any version of fish is considered "newer" than itself because this
    # function is mostly used for feature gatekeeping.
    string match -q "$this_ver" "$that_ver"; and return 0

    for level in 1 2 3 4
        test "$this_ver[$level]" -gt "$that_ver[$level]"; and return 0
        test "$this_ver[$level]" -lt "$that_ver[$level]"; and return 1
    end

    return 0
end
