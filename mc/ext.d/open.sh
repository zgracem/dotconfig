#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Midnight Commander open script
# -----------------------------------------------------------------------------

# get selected files
# echo -E ${MC_EXT_SELECTED} | read -a files
echo ${MC_EXT_SELECTED} | read -a files

if (( ${#files[@]} == 0 )); then
    exit 1
fi

echo "${#files[@]} file(s) selected"
declare -p files
read key; exit

# for var in MC_EXT_BASENAME MC_EXT_FILENAME MC_EXT_CURRENTDIR MC_EXT_SELECTED MC_EXT_ONLYTAGGED; do
#     declare -p "$var"
# done
read key; exit

for file in "${files[@]}"; do
    if [[ -n $1 ]]; then
        type="$1"
        echo "type: $type"
    fi

    echo "$MC_EXT_CURRENTDIR/$file"
done

read key
exit

# -----------------------------------------------------------------------------

case $type in
    audio)
        :
        ;;
    browser)
        :
        ;;
    default)
        :
        ;;
    image)
        :
        ;;
    iwork)
        :
        ;;
    markdown)
        :
        ;;
    msoffice)
        :
        ;;
    pdf)
        :
        ;;
    video)
        :
        ;;
esac

# for var in MC_EXT_BASENAME MC_EXT_FILENAME MC_EXT_CURRENTDIR MC_EXT_SELECTED MC_EXT_ONLYTAGGED; do
#     declare -p "$var"
# done
