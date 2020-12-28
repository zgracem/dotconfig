function mkmv --description 'Create a directory, then move files into it'
    command mkdir -p $argv[-1]
    and mv $argv
end
