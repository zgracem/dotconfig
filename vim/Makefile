# ----------------------------------------------------------------------------
# vim
# ----------------------------------------------------------------------------

include ../common.mk

# create cache & data dirs
install: | $(datadir)/vim $(XDG_CACHE_HOME)/vim $(XDG_STATE_HOME)/vim
$(datadir)/vim $(XDG_CACHE_HOME)/vim $(XDG_STATE_HOME)/vim:
	mkdir -pv $@

# packages
install: $(datadir)/vim/pack/.installed
$(datadir)/vim/pack/.installed:
	$(XDG_CONFIG_HOME)/libexec/init/vim-pack.fish && touch $@
