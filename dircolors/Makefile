# ----------------------------------------------------------------------------
# dircolors: build .ls_colors files
# ----------------------------------------------------------------------------

include ../common.mk

outdir := $(datadir)/dircolors

install: $(outdir)/thirty2k.ls_colors $(outdir)/thirty2k.ls_colors.fish

$(outdir)/%.ls_colors: %.dircolors | $(outdir)
	dircolors -b $< >$@

$(outdir)/%.ls_colors.fish: %.dircolors | $(outdir)
	dircolors -c $< >$@

$(outdir):
	$(MKDIR) $(outdir)

.PHONY: uninstall
uninstall:
	rm -fv $(outdir)/thirty2k.*
