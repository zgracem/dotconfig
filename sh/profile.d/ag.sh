_inPath ag || return

ag()
{ #: - search files and directories in the current directory
  command ag \
      --color-path="34" --color-line-number="36" --color-match="1;4;35" \
      --hidden --skip-vcs-ignores --smart-case \
      "$@"
}
