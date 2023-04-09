.PHONY: all
all:

include ../common.mk

# Maestral: install .mignore file
# (Not a symlink because Maestral can't sync symlinks)
~/Dropbox/.mignore: .mignore
	$(INSTALL_DATA) -- $< $@
.mignore:
	maestral status | grep -Eq 'Cannot upload symlink' && \
	cd ~/Dropbox && fd -u -ts -tl --no-follow --strip-cwd-prefix | tee $(realpath $@)
all: ~/Dropbox/.mignore
