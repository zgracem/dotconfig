# Create symlinks for file that absolutely *must* be in the home directory >:(

# Alias
.PHONY: symlinks

# Output files
SYMLINKS := ~/.irbrc \
						~/.stow-global-ignore \
						~/.stowrc \
						~/.tmux.conf \
						~/.vimrc

# Map input files to output files
~/.irbrc: ruby/irbrc
~/.stow-global-ignore: stow/stow-global-ignore
~/.stowrc: stow/stowrc
~/.tmux.conf: tmux/tmux.conf
~/.vimrc: vim/vimrc

# How to generate 
$(SYMLINKS):
	ln -s .config/$< $@

# Map alias to list of output files
symlinks: $(SYMLINKS)
