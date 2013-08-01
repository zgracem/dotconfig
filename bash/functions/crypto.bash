# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/crypto.bash
# ------------------------------------------------------------------------------

_inPath gpg || return

encrypt()
{   # encrypt a file for my own use
    declare inFile="$1" outFile="${inFile}.gpg"

    gpg --recipient "$EMAIL" --output "$outFile" --encrypt "$inFile" &&
        echo "$inFile -> $outFile"
}

decrypt()
{   # corresponding decrypt function
    declare inFile="$1" outFile="${inFile%.gpg}"

    gpg --output "$outFile" --decrypt "$inFile" &&
        echo "$inFile -> $outFile"
}
