function wget
    if is-macos
        command wget --xattr $argv
    else
        command wget $argv
    end
end
