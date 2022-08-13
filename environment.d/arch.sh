# -----------------------------------------------------------------------------
# architecture & multi-core processing
# -----------------------------------------------------------------------------

if [ -z "$NUMBER_OF_PROCESSORS" ]; then
  NUMBER_OF_PROCESSORS="$(getconf _NPROCESSORS_ONLN 2>/dev/null)" &&
    export NUMBER_OF_PROCESSORS
fi

if [ "$NUMBER_OF_PROCESSORS" -gt 1 ]; then
  export MAKEFLAGS="-j${NUMBER_OF_PROCESSORS}"
  export BUNDLE_JOBS="$NUMBER_OF_PROCESSORS"
fi

if command -v sysctl >/dev/null && [ -z "$PROCESSOR_ARCHITECTURE" ]; then
  PROCESSOR_ARCHITECTURE="$(sysctl -n hw.machine 2>/dev/null)" &&
    export PROCESSOR_ARCHITECTURE
fi

if [ -n "$PROCESSOR_ARCHITECTURE" ] && [ "${ARCHFLAGS#*-arch}" = "$ARCHFLAGS" ]; then
  export ARCHFLAGS="${ARCHFLAGS:+$ARCHFLAGS }-arch ${PROCESSOR_ARCHITECTURE}"
fi
