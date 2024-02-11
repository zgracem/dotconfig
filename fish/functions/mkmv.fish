function mkmv --description 'Create a directory, then move files into it'
    mkdir -pv $argv[-1]
    and /bin/mv -iv $argv
end
