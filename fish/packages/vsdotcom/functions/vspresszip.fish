if string match -q 'Citadel.*' $hostname
    function vspresszip -d 'Create/update a .zip file' -a slug
        set -l zip_file
        if string match -q '*_*' $slug
            set zip_file "zip/$slug.zip"
        else
            set zip_file "zip/vivekshraya_"$slug"_press.zip"
        end

        pushd $HOME/Dropbox/VS/www/vsdotcom/src/media/images/press
        roll "$zip_file" *"$slug"*.jpg
        popd
    end
end
