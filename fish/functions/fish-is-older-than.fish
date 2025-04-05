function fish-is-older-than -a test_version
    not fish-is-newer-than $test_version
end
