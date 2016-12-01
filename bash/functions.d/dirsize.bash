# display total size of a directory
dirsize()
{ 
  du -sh "${1-.}"
  #   │└─ human-readable sizes (e.g. 640K 1.44M 4G)
  #   └── summarize (display total only)
}

# sort files and directories by size
sizes()
{ 
  command du -sh "${1-.}"/* \
  | sort -rh
  #       │└─ compare human-readable numbers
  #       └── reverse sort (largest sizes first)
}
