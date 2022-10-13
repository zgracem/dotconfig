include ../common.mk

WINPROFILE := $(shell cygpath -au "$(USERPROFILE)")
DOWNLOADS := $(WINPROFILE)/Downloads

# -- PuTTY ---------------------------------------------------------------------

PUTTY_DIR := $(WINPROFILE)/Applications/PuTTY
PUTTY_VER := 0.77
.PHONY: putty
install: putty

putty: | $(PUTTY_DIR)/putty.exe
$(PUTTY_DIR)/putty.exe: $(DOWNLOADS)/portable_putty_077_0.19.0_all_in_one.zip
	unzip -u -j -d $(@D) $< '$(PUTTY_VER)/*.exe'

$(DOWNLOADS)/portable_putty_077_0.19.0_all_in_one.zip:
	cd $(@D) && curl -OJ http://jakub.kotrla.net/putty/$(@F)

putty: $(PUTTY_DIR)/putty.conf
$(PUTTY_DIR)/putty.conf: | $(XDG_CONFIG_HOME)/putty/putty.conf
	ln -sfv $< $@

# https://www.chiark.greenend.org.uk/~sgtatham/putty/wishlist/cygwin-terminal-window.html
# https://superuser.com/a/1736851
# https://manpages.debian.org/unstable/putty-tools/psusan.1.en.html
putty: /cygdrive/c/cygwin64/bin/psusan.exe
/cygdrive/c/cygwin64/bin/psusan.exe: | $(DOWNLOADS)/putty-$(PUTTY_VER)/psusan.exe
	$(INSTALL_PROGRAM) -- $< $@

$(DOWNLOADS)/putty-$(PUTTY_VER)/psusan.exe: | $(DOWNLOADS)/putty-$(PUTTY_VER).tar.gz
	cd $(<D) && tar -zxvf $(<F) && cd $(@D) && cmake . && cmake --build .

$(DOWNLOADS)/putty-$(PUTTY_VER).tar.gz:
	cd $(@D) && curl -OJ https://the.earth.li/~sgtatham/putty/latest/$(@F)

putty: | $(PUTTY_DIR)
$(PUTTY_DIR):
	mkdir -pv $@

SESSIONS  =
SESSIONS += ../../.private/putty/sessions/Cygwin.session
SESSIONS += ../../.private/putty/sessions/Opalstack.session

$(SESSIONS): Default%20Settings.session
$(SESSIONS): %.session: %.patch
	patch -o $@ Default%20Settings.session $<

.PHONY: putty-sessions
putty-sessions: $(SESSIONS)
install: putty-sessions

# PATCHES := $(SESSIONS:session=patch)
# $(PATCHES):
# 	diff -u Default%20Settings.session $< >$@
