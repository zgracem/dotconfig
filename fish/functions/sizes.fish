function sizes --description 'Sort files and directories by size'
  du -sh ./* | sort -rh
end
