webster()
{ #: - search Webster's Dictionary, 1913 edition
  #: > http://jsomers.net/blog/dictionary
  #: < sdcv (StarDict)
  _require sdcv || return

  sdcv --non-interactive \
       --use-dict "Webster's Revised Unabridged Dictionary (1913)" \
       "$@"
}
