function _fish_is_newer_than -a test_version
    function __fish_versinfo -a fish_ver
        set -l version_info (string split "." "$fish_ver" | string split "-")
        test -n "$version_info[4]"
        or set version_info[4] 0

        string join \n $version_info
    end

    set -l this_ver (__fish_versinfo $version)
    set -l that_ver (__fish_versinfo $test_version)

    test "$this_ver" = "$that_ver"; and return 1

    for level in 1 2 3 4
        test "$this_ver[$level]" -gt "$that_ver[$level]"; and return 0
        test "$this_ver[$level]" -lt "$that_ver[$level]"; and return 1
    end

    return 1
end

function _fish_is_older_than -a test_version
    not _fish_is_newer_than $test_version
end

# ----------------------------------------------------------------------------

if test -n "$VSCODE_PID" -a "$TERM" = "dumb"
    set -l versions 1.{22,50}.0 2.{3.0,39.8} 3.{0,1}.{0,1,2} \
        3.1.2-{1578-gd3192d37a,1827-gf03ff8cd0} 3.1.3 3.2.0 4.0.0

    echo "current fish : $FISH_VERSION"

    for _version_ in (string join \n $versions | sort)
        if _fish_is_newer_than $_version_
            echo "    newer than" $_version_
        else
            echo "not newer than" $_version_
        end
    end
    exit
end

# ----------------------------------------------------------------------------

if _fish_is_older_than 3.1.0
    set -g -p fish_complete_path (realpath (dirname (status filename))/..)/completions
end

exit 101
