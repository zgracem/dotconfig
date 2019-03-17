function deleteemptydirs
  find . -empty -type d -print -delete
end
