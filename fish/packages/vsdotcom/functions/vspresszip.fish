if string match -q 'Athena.*' $hostname
  function vspresszip -d 'Create/update a .zip file' -a slug
    pushd $HOME/Dropbox/www/vs2017/src/media/images/press
    rollup "zip/vivekshraya_"$slug"_press.zip" *"$slug"_*.jpg
    popd
  end
end
