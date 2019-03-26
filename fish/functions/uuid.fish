function uuid --description 'Generate a UUID and copy it to the clipboard'
  set -l uuid (uuidgen)
  echo -n $uuid | pbcopy
  echo $uuid
end
