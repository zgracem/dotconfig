# -----------------------------------------------------------------------------
# architecture & multi-core processing
# -----------------------------------------------------------------------------

if command -v -q getconf; and not set -Uq NUMBER_OF_PROCESSORS
    set -Ux NUMBER_OF_PROCESSORS (getconf _NPROCESSORS_ONLN 2>/dev/null)
end

if [ $NUMBER_OF_PROCESSORS -gt 1 ]
    set -gx MAKEFLAGS -j$NUMBER_OF_PROCESSORS
    set -gx BUNDLE_JOBS $NUMBER_OF_PROCESSORS
end

if command -v -q sysctl; and not set -Uq PROCESSOR_ARCHITECTURE
    set -Ux PROCESSOR_ARCHITECTURE (sysctl -n hw.machine 2>/dev/null)
end

if set -q PROCESSOR_ARCHITECTURE; and string match -vq -- -arch "$ARCHFLAGS"
    set -gx -a ARCHFLAGS "-arch $PROCESSOR_ARCHITECTURE"
end
