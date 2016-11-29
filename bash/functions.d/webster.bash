_inPath sdcv || return

# Wrapper for StarDict + Webster's 1913
# >> http://jsomers.net/blog/dictionary
webster()
{ 
  sdcv --non-interactive \
       --use-dict "Webster's Revised Unabridged Dictionary (1913)" \
       "$@"
}
