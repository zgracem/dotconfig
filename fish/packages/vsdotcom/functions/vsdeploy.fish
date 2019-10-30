if string match -q 'Athena.*' $hostname
  function vsdeploy --description 'Deploy vivekshraya.com'
    ~/Dropbox/www/vs2017/bin/sync.sh $argv
  end
end
