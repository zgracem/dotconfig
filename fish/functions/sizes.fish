function sizes --description 'Sort files and directories by size'
  du -sh "$PWD"/* | sort -rh
end
