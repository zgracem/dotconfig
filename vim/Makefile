# ----------------------------------------------------------------------------
# vim
# ----------------------------------------------------------------------------

include ../common.mk

# create cache & data dirs
vim_dirs = $(datadir)/vim $(XDG_CACHE_HOME)/vim $(XDG_STATE_HOME)/vim
install: | $(vim_dirs)
$(vim_dirs):
	mkdir -pv $@

# packages
install: $(datadir)/vim/pack/.installed
$(datadir)/vim/pack/.installed:
	$(XDG_CONFIG_HOME)/libexec/init/vim-pack.fish && touch $@
