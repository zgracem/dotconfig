# sort files and directories by size
sizes()
{ 
  command du -sh "${1-.}"/* \
  | sort -rh
  #       │└─ compare human-readable numbers
  #       └── reverse sort (largest sizes first)
}
