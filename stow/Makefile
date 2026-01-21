include ../common.mk

# create config symlinks in $HOME
~/.stow-global-ignore: .stow-global-ignore
	$(LN) .config/stow/$< $@
install: ~/.stow-global-ignore

~/.stow-global-ignore: .stowrc
	$(LN) .config/stow/$< $@
install: ~/.stowrc
