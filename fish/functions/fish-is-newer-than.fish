function fish-is-newer-than -a test_version
    # Account for broken builds and assume they're bleeding-edge
    string match -q unknown "$version"; and return 0

    set -l this_ver (fish_versinfo $version)
    set -l that_ver (fish_versinfo $test_version)

    # Any version of fish is considered "newer" than itself because this
    # function is mostly used for feature gatekeeping.
    string match -q "$this_ver" "$that_ver"; and return 0

    for level in 1 2 3 5 4 # X Y Z B A
        test "$this_ver[$level]" -gt "$that_ver[$level]"; and return 0
        test "$this_ver[$level]" -lt "$that_ver[$level]"; and return 1
    end

    return 0
end
