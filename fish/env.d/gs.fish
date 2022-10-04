in-path gs; or exit

set -gx GS_OPTIONS
# Suppress startup messages
set -a GS_OPTIONS -q
# Suppress other output too ("batch file mode")
set -a GS_OPTIONS -dBATCH
# Disable the prompt and pause after each page
set -a GS_OPTIONS -dNOPAUSE
# Do not restrict file operations
set -a GS_OPTIONS -dNOSAFER
