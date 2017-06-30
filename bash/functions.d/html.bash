html()
{ #: - opens HTML string (from arg or stdin) in BROWSER
  ~/scripts/util/md.sh <<< "${@:-$(</dev/stdin)}"
}
