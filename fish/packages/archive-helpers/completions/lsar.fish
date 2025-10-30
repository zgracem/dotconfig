# lsar <https://theunarchiver.com/command-line>

complete -c lsar -s l -o long -d 'Print more information'
complete -c lsar -s t -o test -d 'Test integrity of archive if possible'
complete -c lsar -s p -o password -x -d 'Password for decrypting protected archives'
complete -c lsar -s e -o encoding -x -d 'Encoding for filenames in the archive'
complete -c lsar -s E -o password-encoding -x -d 'Encoding for the archive password'
complete -c lsar -o pe -o print-encoding -d 'Print auto-detected encoding and confidence factor'
complete -c lsar -s i -o indexes -d 'Specify files to list by index'
complete -c lsar -s j -o json -d 'List in JSON format'
complete -c lsar -o ja -o json-ascii -d 'List in JSON format as pure ASCII'
complete -c lsar -o nr -o no-recursion -d 'Do not list contents of nested archives'
complete -c lsar -s h -o help -d 'Display help'
