# -----------------------------------------------------------------------------
# thumb drive setup
# -----------------------------------------------------------------------------

myDrive='SILVER'

if dir_drive=$(find_drive "$myDrive"); then
  export dir_drive
fi
