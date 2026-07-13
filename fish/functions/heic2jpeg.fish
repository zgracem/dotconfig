function heic2jpeg --description 'Convert HEIC files (iOS 11+) to JPEG'
    if not command -q sips
        return 127
    else if not set -q argv[1]
        return 2
    else
        for heic_img in $argv
            set -l jpeg_img (path change-extension .jpg "$heic_img")
            sips -s format jpeg "$heic_img" --out "$jpeg_img"
            and touch -r $heic_img $jpeg_img
            or break
        end
    end
end
