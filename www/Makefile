# ----------------------------------------------------------------------------
# www
# ----------------------------------------------------------------------------

include ../common.mk

userContent.css: userContent.sass
	sass $< >$@ && \
	defaults write -app Safari UserStyleSheetEnabled -bool true && \
	defaults write -app Safari UserStyleSheetLocationURLString $(realpath $@)
install: userContent.css
