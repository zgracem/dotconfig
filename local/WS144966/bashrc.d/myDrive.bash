# -----------------------------------------------------------------------------
# thumb drive setup
# -----------------------------------------------------------------------------

myDrive='SILVER'

# set the variable if it's not already
if [[ -z $dir_drive ]]; then
    export dir_drive="$(findDrive $myDrive)"
fi
