# display total size of a directory
dirsize()
{ 
  du -sh "${1-.}"
  #   │└─ human-readable sizes (e.g. 640K 1.44M 4G)
  #   └── summarize (display total only)
}
