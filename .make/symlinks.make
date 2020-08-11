# Create symlinks for files that absolutely *must* be in the home directory >:(

# Alias
.PHONY: symlinks

# Output files
SYMLINKS := ~/.jq
						~/.stow-global-ignore \
						~/.stowrc \
						~/.tmux.conf \
						~/.vimrc

# Map input files to output files
~/.jq: jq
~/.stow-global-ignore: stow/stow-global-ignore
~/.stowrc: stow/stowrc
~/.tmux.conf: tmux/tmux.conf
~/.vimrc: vim/vimrc

# How to generate
$(SYMLINKS):
	/bin/ln -s .config/$< $@

# Map alias to list of output files
symlinks: $(SYMLINKS)
