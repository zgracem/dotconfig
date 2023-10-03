# ----------------------------------------------------------------------------
# bat: install and/or (re)build syntaxes
# ----------------------------------------------------------------------------

include ../common.mk

# clones repos if necessary, then runs `bat cache --build`
install: $(XDG_CACHE_HOME)/bat/syntaxes.bin
$(XDG_CACHE_HOME)/bat/syntaxes.bin: /usr/local/bin/bat
	$(XDG_CONFIG_HOME)/libexec/bat-syntaxes.fish
/usr/local/bin/bat:
	brew install bat
