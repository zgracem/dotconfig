#!/usr/bin/env bash

DAYONE_APP="/Applications/Day One.app"
DAYONE_LINK="$HOME/Applications/DayOne.app"

if [[ -L $DAYONE_LINK ]]; then
    exit 0
elif [[ -e $DAYONE_LINK ]]; then
    echo "Error! $DAYONE_LINK exists but is not a symbolic link!" >&2
    exit 1
elif [[ -e $DAYONE_APP ]]; then
    ln -sfv "$DAYONE_APP" "$DAYONE_LINK"
else
    echo "Error! $DAYONE_APP not found!" >&2
    exit 1
fi
