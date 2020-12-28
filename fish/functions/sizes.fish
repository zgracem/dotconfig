function sizes --description 'Sort files and directories by size'
    set -q argv[1]; or set argv[1] (pwd)
    du -sh $argv/* | sort -rh
end
