function webp2png
    if not command -q dwebp
        return 127
    else if not set -q argv[1]
        return 2
    else
        for webp_img in $argv
            set -l png_img (path change-extension .png $webp_img)
            dwebp -mt -o $png_img $webp_img
            and touch -r $webp_img $png_img
            or break
        end
    end
end
