sizes()
{ #: - sort files and directories in directory $1 (or PWD) by size
  command du -sh "${1-.}"/* \
  | sort -rh
  #       │└─ compare human-readable numbers
  #       └── reverse sort (largest sizes first)
}
