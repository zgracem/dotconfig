string match -q "CYGWIN*" (/usr/bin/uname -s); or return

# When launched in e.g. VSCode's integrated terminal, only Windows' %PATH% will
# be present, and all other config files will error out because they can't find
# any executables. This allows things to progress as far as ../paths.fish.
set -p PATH /bin
set -p PATH /usr/bin
