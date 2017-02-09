_inPath sdcv || return

webster()
{ #: - search Webster's Dictionary, 1913 edition
  #: > http://jsomers.net/blog/dictionary
  #: < sdcv (StarDict)
  sdcv --non-interactive \
       --use-dict "Webster's Revised Unabridged Dictionary (1913)" \
       "$@"
}
