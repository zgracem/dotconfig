# -----------------------------------------------------------------------------
# thumb drive setup
# -----------------------------------------------------------------------------

myDrive='SILVER'

if dir_drive=$(find_drive "$myDrive" 2>/dev/null); then
  export dir_drive
fi
