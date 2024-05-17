function wget
    command -q wget; or return 127
    if is-macos
        command wget --xattr $argv
    else
        command wget $argv
    end
end
