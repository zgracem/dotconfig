function vsdotcom --description "Manage vivekshraya.com"
    string match -q 'Citadel.*' $hostname; or return 127
    set -l script $HOME/Dropbox/VS/www/vsdotcom/bin/vsdotcom.fish

    test -x $script; or chmod -c u+x $script

    $script $argv
end
