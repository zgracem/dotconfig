include ../common.mk

OUTDIR := $(XDG_CACHE_HOME)/dircolors

.PHONY: dircolors/all
dircolors/all: thirty2k

.PHONY: thirty2k
thirty2k: $(OUTDIR)/thirty2k.ls_colors $(OUTDIR)/thirty2k.ls_colors.fish

$(OUTDIR)/%.ls_colors: %.dircolors | $(OUTDIR)/
	dircolors -b $< >$@

$(OUTDIR)/%.ls_colors.fish: %.dircolors | $(OUTDIR)/
	dircolors -c $< >$@

$(OUTDIR)/:
	mkdir -p $(OUTDIR)

.PHONY: clean
clean:
	rm -f $(OUTDIR)/*.ls_colors
