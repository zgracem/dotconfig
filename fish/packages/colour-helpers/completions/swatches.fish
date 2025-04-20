complete -c swatches -s s -l size -x -a "128 256 512" -d "Set pixel size"
complete -c swatches -s t -l tile -x -a "8x2 7x4 6x3" -d "Set tile layout"
complete -c swatches -s o -l output -x -a '(__fish_complete_files)' -d "Output file location"
