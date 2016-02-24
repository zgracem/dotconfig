#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Midnight Commander action script
# -----------------------------------------------------------------------------

declare action="$1" filetype="$2" name=""
declare -a basenames=() files=()

# get selected files
echo ${MC_EXT_SELECTED} | read -a basenames

if (( ${#basenames[@]} == 0 )); then
    exit 1
fi

for name in "${basenames[@]}"; do
    files+=("$MC_EXT_CURRENTDIR/$name")
    unset -v name file
done

echo "action:   $action"
echo "filetype: $filetype"
echo "${#files[@]} files:"
declare -p files

read key
exit

# -----------------------------------------------------------------------------

case $filetype in
    default)
        :
        ;;
    text)
        :
        ;;
    markdown)
        :
        ;;
    image)
        :
        ;;
    audio)
        :
        ;;
    video)
        :
        ;;
    pdf)
        :
        ;;
    iwork)
        :
        ;;
    msoffice-xml)
        :
        ;;
    msoffice)
        :
        ;;
    browser)
        :
        ;;
esac

# for var in MC_EXT_BASENAME MC_EXT_FILENAME MC_EXT_CURRENTDIR MC_EXT_SELECTED MC_EXT_ONLYTAGGED; do
#     declare -p "$var"
# done
