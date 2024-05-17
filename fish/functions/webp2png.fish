function webp2png
    if not command -q dwebp
        return 127
    else if not set -q argv[1]
        return 2
    else
        for img in $argv
            dwebp -mt -o (path change-extension .png $img) $img
        end
    end
end
