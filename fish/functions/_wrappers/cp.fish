function cp --description 'Copy files and directories'
    set -p argv -aiv
    command cp $argv
end
