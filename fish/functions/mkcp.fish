function mkcp --description 'Create a directory, then copy files into it'
    mkdir -pv $argv[-1]
    and cp -aiv $argv
end
