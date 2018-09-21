.PHONY: thirty2k default clean all

XDG_CACHE_HOME ?= ~/var/cache
OUTDIR = $(XDG_CACHE_HOME)/dircolors

all: thirty2k default
thirty2k: $(OUTDIR)/thirty2k.ls_colors
default: $(OUTDIR)/default.ls_colors

$(OUTDIR)/%.ls_colors: %.dir_colors $(OUTDIR)/
	dircolors -b $< > $@

$(OUTDIR)/:
	mkdir -p $(OUTDIR)

clean:
	rm -f $(OUTDIR)/*.ls_colors
