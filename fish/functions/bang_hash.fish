function bang_hash
    set -l token_index (string split -f2 : $argv[1])
    set -l tokens (commandline -cx; commandline -ct)
    set -q tokens[$token_index]; or return
    commandline -f backward-delete-char
    commandline --insert "$tokens[$token_index] "
end
