function fish_is_older_than -a test_version
    not fish_is_newer_than $test_version
end
