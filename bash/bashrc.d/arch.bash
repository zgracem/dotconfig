# -----------------------------------------------------------------------------
# architecture & multi-core processing
# -----------------------------------------------------------------------------

if [[ -z $NUMBER_OF_PROCESSORS ]]; then
	export NUMBER_OF_PROCESSORS="$(getconf _NPROCESSORS_ONLN 2>&-)"
fi

if (( NUMBER_OF_PROCESSORS > 1 )); then
    export MAKEFLAGS="-j${NUMBER_OF_PROCESSORS}"
fi

if _inPath sysctl && [[ -z $PROCESSOR_ARCHITECTURE ]]; then
    export PROCESSOR_ARCHITECTURE="$(sysctl -n hw.machine 2>/dev/null)"
fi

if [[ -n $PROCESSOR_ARCHITECTURE && ! $ARCHFLAGS =~ \-arch ]]; then
    export ARCHFLAGS="${ARCHFLAGS:+$ARCHFLAGS }-arch ${PROCESSOR_ARCHITECTURE}"
fi
