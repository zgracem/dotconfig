function uuid --description 'Generate a UUID and copy it to the clipboard'
    uuidgen $argv | tbcopy
end
