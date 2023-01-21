.PHONY: all
all: $(CURDIR)/helpfile.html
all: $(CURDIR)/helpfile.css

SLIM_OPTS  = --option format=:html
SLIM_OPTS += --option tabsize=2
SLIM_OPTS += --option sort_attrs=false
# SLIM_OPTS += --pretty
SLIM_OPTS += --trace

SASS_OPTS  = --style=compressed
SASS_OPTS += --no-source-map

PRETTIER_OPTS  = --parser=html
PRETTIER_OPTS += --html-whitespace-sensitivity=css
PRETTIER_OPTS += --bracket-same-line
PRETTIER = ~/.local/share/npm/bin/prettier $(PRETTIER_OPTS)

$(CURDIR)/%.html: $(CURDIR)/%.slim
	slimrb $(SLIM_OPTS) $< | $(PRETTIER) > $@

$(CURDIR)/%.css: $(CURDIR)/%.scss
	sass $(SASS_OPTS) $< > $@
