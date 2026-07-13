function imgfix
    set -l webp_files *.webp
    set -l heic_files *.{heic,HEIC}

    set -q webp_files[1]; and webp2png $webp_files
    set -q heic_files[1]; and heic2jpeg $heic_files
end
