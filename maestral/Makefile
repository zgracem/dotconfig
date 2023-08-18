# ----------------------------------------------------------------------------
# Maestral: install .mignore file
# ----------------------------------------------------------------------------

include ../common.mk

install: ~/Dropbox/.mignore

# (Not a symlink because Maestral can't sync symlinks)
~/Dropbox/.mignore: .mignore
	$(INSTALL_DATA) -- $< $@

.mignore:
	cd ~/Dropbox && fd -u -ts -tl --no-follow --strip-cwd-prefix | \
	tee $(realpath $@)
