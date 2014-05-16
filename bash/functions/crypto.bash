# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/crypto.bash
# ------------------------------------------------------------------------------

if _inPath keybase; then
    encrypt()
    {   # encrypt a file for my own use
        declare inFile="$1" outFile="$1.asc"

        if [[ ! -f $inFile ]]; then
            scold "$FUNCNAME" "$inFile: not found"
            return 1
        elif [[ -e $outFile ]]; then
            scold "$FUNCNAME" "$outFile: already exists"
            return 1
        fi

        keybase encrypt zozo < "$inFile" > "$outFile" &&
            echo "$inFile -> $outFile"
    }

    decrypt()
    {   # corresponding decrypt function
        declare inFile="$1" outFile="${1%.asc}"

        if [[ ! -f $inFile ]]; then
            scold "$FUNCNAME" "$inFile: not found"
            return 1
        elif [[ -e $outFile ]]; then
            scold "$FUNCNAME" "$outFile: already exists"
            return 1
        fi

        keybase decrypt "$inFile" > "$outFile" &&
            echo "$inFile -> $outFile"
    }
elif _inPath gpg; then
    encrypt()
    {
        declare inFile="$1" outFile="$1.gpg"

        gpg --recipient "$EMAIL" --output "$outFile" --encrypt "$inFile" &&
            echo "$inFile -> $outFile"
    }

    decrypt()
    {
        declare inFile="$1" outFile="${1%.gpg}"

        gpg --output "$outFile" --decrypt "$inFile" &&
            echo "$inFile -> $outFile"
    }
else
    return 0
fi
