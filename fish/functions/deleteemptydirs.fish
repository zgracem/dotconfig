function deleteemptydirs
  find . -name '.DS_Store' -type f -delete
  and find . -empty -type d -print -delete
end
