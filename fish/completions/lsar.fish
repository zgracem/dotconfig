# lsar <https://unarchiver.c3.cx/commandline>

complete -c lsar -s l -o long -d 'Print more information about each file'
complete -c lsar -s t -o test -d 'Test the integrity of the files in the archive, if possible'
complete -c lsar -s p -o password -x -d 'The password to use for decrypting protected archives'
complete -c lsar -s e -o encoding -x -d 'The encoding to use for filenames in the archive, when it is not known'
complete -c lsar -s E -o password-encoding -x -d 'The encoding to use for the password for the archive'
complete -c lsar -o pe -o print-encoding -d 'Print the auto-detected encoding and the confidence factor'
complete -c lsar -s i -o indexes -d 'Specify the files to list by index'
complete -c lsar -s j -o json -d 'Print the listing in JSON format'
complete -c lsar -o ja -o json-ascii -d 'Print the listing in JSON format, encoded as pure ASCII'
complete -c lsar -o nr -o no-recursion -d 'Do not attempt to list the contents of archives in other archives'
complete -c lsar -s h -o help -d 'Display help information'
