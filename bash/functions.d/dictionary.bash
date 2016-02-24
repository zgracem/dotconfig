if _inPath dict; then
    def()
    {   # dictionary wrapper

        dict -d wn "$@"
    }
fi

if _inPath sdcv; then
    webster()
    {   # wrapper for StarDict + Webster's 1913

        sdcv \
            --non-interactive \
            --use-dict "Webster's Revised Unabridged Dictionary (1913)" \
            "$@"
    }
fi
