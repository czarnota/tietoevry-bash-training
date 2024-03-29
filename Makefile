SLIDE_FILES=$(patsubst %/README.md, %/slides.html, $(shell find . -name "README.md"))
PDF_FILES=$(patsubst %/README.md, %/main.pdf, $(shell find . -name "README.md"))
DIAGRAM_FILES=$(addsuffix .lock, $(shell find . -name diagrams))

SLIDES=bin/slides.sh
DIAGRAMS=bin/diagrams.sh

all: $(SLIDE_FILES) $(DIAGRAM_FILES)

$(SLIDE_FILES): %slides.html : %README.md $(SLIDES)
	$(SLIDES) $< $@

$(PDF_FILES): %main.pdf: %README.md $(SLIDES)
	$(SLIDES) $< $@

$(DIAGRAM_FILES): %.lock : % $(DIAGRAMS)
	$(DIAGRAMS) $<
	touch $@

clean:
	rm $(DIAGRAM_FILES)
