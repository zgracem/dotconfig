dirsize()
{ #: - display total size of directory $1 (or PWD)
  #: $ dirsize [dir]
  du -sh "${1-.}"
  #   │└─ human-readable sizes (e.g. 640K 1.44M 4G)
  #   └── summarize (display total only)
}
