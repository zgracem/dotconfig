function deleteemptydirs --description 'Delete empty dirs in PWD'
  find . -empty -type d -print -delete
end
