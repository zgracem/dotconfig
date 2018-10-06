# -----------------------------------------------------------------------------
# symlinks
# -----------------------------------------------------------------------------

.PHONY: symlinks

SYMLINKS := ~/.irbrc ~/.stow-global-ignore ~/.stowrc ~/.tmux.conf ~/.vimrc

~/.irbrc: ruby/irbrc
~/.stow-global-ignore: stow/stow-global-ignore
~/.stowrc: stow/stowrc
~/.tmux.conf: tmux/tmux.conf
~/.vimrc: vim/vimrc

$(SYMLINKS):
	ln -s .config/$< $@

symlinks: $(SYMLINKS)
