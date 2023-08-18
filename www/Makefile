# ----------------------------------------------------------------------------
# www
# ----------------------------------------------------------------------------

include ../common.mk

userContent.css: userContent.sass
	sass $< >$@ &&
install: userContent.css
	defaults write -app Safari UserStyleSheetEnabled -bool true && \
	defaults write -app Safari UserStyleSheetLocationURLString $(realpath $<)
