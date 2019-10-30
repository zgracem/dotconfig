if string match -q 'Athena.*' $hostname
  function vspresszip -d 'Create/update a .zip file' -a slug
    set -l dir $HOME/Dropbox/www/vs2017/src/media/images/press
    test -d $dir; or return 1

    pushd $dir
    rollup "zip/vivekshraya_"$slug"_press.zip" *"$slug"_*.jpg
    popd
  end
end
