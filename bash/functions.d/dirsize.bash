dirsize()
{ # display total dize of a directory
  command du -sh "${1-$PWD}"
  #           │└── human-readable sizes (e.g. 640K 1.44M 4G)
  #           └─── summarize (display total only)
}

sizes()
{ # sort files and directories by size
  dirsize "${1-$PWD}"/* \
  | sort -rh
  #       │└────── compare human-readable numbers
  #       └─────── reverse sort (largest sizes first)
}
