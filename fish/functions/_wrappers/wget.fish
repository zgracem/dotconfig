in-path wget; or exit

function wget
    if is-macos
        # Save the original URL and the Referer HTTP header in extended attributes.
        set -p argv --xattr
    end

    command wget $argv
end
