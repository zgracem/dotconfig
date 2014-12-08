# exclude ._resourceforks from tarballs
export COPYFILE_DISABLE=true

# avoid flattening contents of tar files
export COMP_TAR_INTERNAL_PATHS=1

if [[ $OSTYPE =~ cygwin ]]; then
	alias tar='/usr/bin/bsdtar'
fi
