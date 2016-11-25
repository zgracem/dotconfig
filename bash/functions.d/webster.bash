_inPath sdcv || return

webster()
{ # wrapper for StarDict + Webster's 1913
  sdcv --non-interactive \
       --use-dict "Webster's Revised Unabridged Dictionary (1913)" \
       "$@"
}
