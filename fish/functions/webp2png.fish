function webp2png
    for img in $argv
        dwebp -mt -o (path change-extension .png $img) $img
    end
end
