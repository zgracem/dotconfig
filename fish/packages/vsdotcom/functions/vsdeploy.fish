if string match -q 'Citadel.*' $hostname
    function vsdeploy --description 'Deploy vivekshraya.com'
        set script $HOME/Dropbox/VS/www/vsdotcom/bin/vsdeploy.fish
        chmod u+x $script >/dev/null
        $script $argv
    end
end
