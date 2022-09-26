# exclude ._resourceforks from tarballs
set -gx COPYFILE_DISABLE true

# avoid flattening contents of tar files
set -gx COMP_TAR_INTERNAL_PATHS 1
