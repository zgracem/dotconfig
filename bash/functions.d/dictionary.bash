if _inPath dict; then
    def()
    {   # dictionary wrapper

        dict -d wn "$@" \
        | less -F
    }
fi

if _inPath sdcv; then
    webster()
    {   # wrapper for StarDict + Webster's 1913

        local dictionary="Webster's Revised Unabridged Dictionary (1913)"

        sdcv --use-dict "$dictionary" --non-interactive "$@" \
        | less -F
    }
fi
