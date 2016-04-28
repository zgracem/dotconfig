for markdown in multimarkdown Markdown.pl; do
    if _inPath "$markdown"; then
        break
    else
        unset -v markdown
    fi
done

[[ -z $markdown ]] && return

md()
{
    local -a files=()
    local f filename
    local markdown=$markdown

    for filename in "$@"; do
        if [[ -r $filename ]]; then
            if [[ $OSTYPE == cygwin ]]; then
                files+=("$(cygpath -aw "$filename")")
            else
                files+=("$filename")
            fi
        else
            scold "couldn't read file: $filename"
            return $EX_NOINPUT
        fi
    done

    if (( ${#files[@]} < 1 )); then
        scold "Usage: ${FUNCNAME} FILE [FILE ...]"
        return $EX_USAGE
    fi

    local temp_dir=$(mktemp -d -q -t "${FUNCNAME}.${$}.XXXXXX")

    for f in "${!files[@]}"; do
        local in_file="${files[$f]}"
        local base="$(basename "$in_file")"
        local out_file="${temp_dir}/${base%.*}.html"

        if "$markdown" "$in_file" > "$out_file"; then
            local out_url="${temp_dir}/$(urlencode "${base%.*}").html"

            if [[ $OSTYPE == cygwin ]]; then
                out_url="$(cygpath -am "$out_url")"
            fi

            if [[ -n $BROWSER ]]; then
                "$BROWSER" "file:///$out_url"
            else
                echo "$out_file"
            fi
        else
            scold 'could not create HTML file'
            return $EX_CANTCREAT
        fi
    done
}

unset -v markdown
