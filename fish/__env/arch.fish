# -----------------------------------------------------------------------------
# architecture & multi-core processing
# -----------------------------------------------------------------------------

if not set -q NUMBER_OF_PROCESSORS
    set -gx NUMBER_OF_PROCESSORS (getconf _NPROCESSORS_ONLN 2>/dev/null)
end

if test $NUMBER_OF_PROCESSORS -gt 1
    set -gx MAKEFLAGS -j$NUMBER_OF_PROCESSORS
    set -gx BUNDLE_JOBS $NUMBER_OF_PROCESSORS
end
