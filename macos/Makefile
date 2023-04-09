# ----------------------------------------------------------------------------
# MacOS
# ----------------------------------------------------------------------------

include ../common.mk

# Fix missing header file errors when building software
.PHONY: sdk
sdk: $(XDG_CACHE_HOME)/dotfiles/MacOSX-sdk-path.txt
sdk_dir := /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs
$(XDG_CACHE_HOME)/dotfiles/MacOSX-sdk-path.txt: $(sdk_dir)/MacOSX.sdk | $(XDG_CACHE_HOME)/dotfiles
	xcrun --sdk macosx --show-sdk-path >$@
install: sdk

# Create symlinks in $HOME/Library/Application Support
.PHONY: appsupport
appsupport:
	$(XDG_CONFIG_HOME)/libexec/init/appsupport.sh
install: appsupport
