function heic2jpeg --description 'Convert HEIC files (iOS 11+) to JPEG'
    command -q sips; or return 127
    for heic_img in $argv
        set jpeg_img (path change-extension .jpg "$heic_img")
        sips -s format jpeg "$heic_img" --out "$jpeg_img"
        or break
    end
end
