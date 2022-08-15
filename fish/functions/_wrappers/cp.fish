function cp --description 'Copy files and directories'
    set -p argv -a # preserve attributes
    set -p argv -i # confirm before overwriting
    set -p argv -v # verbose
    command cp $argv
end
