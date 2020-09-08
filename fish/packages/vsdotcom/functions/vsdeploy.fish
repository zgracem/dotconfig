if string match -q 'Citadel.*' $hostname
  function vsdeploy --description 'Deploy vivekshraya.com'
    ~/Dropbox/www/vs2017/bin/vsdeploy.fish $argv
  end
end
