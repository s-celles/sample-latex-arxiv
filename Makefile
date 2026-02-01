# Makefile for LaTeX project
# Usage: make [target]

MAIN = main
LATEX = pdflatex
BIBTEX = bibtex

# Default target
all: $(MAIN).pdf

# Full compilation with bibliography
$(MAIN).pdf: $(MAIN).tex references.bib
	$(LATEX) $(MAIN)
	$(BIBTEX) $(MAIN)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)

# Quick compilation (no bibliography update)
quick:
	$(LATEX) $(MAIN)

# Clean auxiliary files
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot
	rm -f *.fls *.fdb_latexmk *.synctex.gz *.nav *.snm

# Clean everything including PDF
distclean: clean
	rm -f $(MAIN).pdf

# Create arXiv submission package
# Note: arXiv requires .bbl file, not .bib
arxiv: $(MAIN).pdf clean-arxiv
	@echo "Creating arXiv submission package..."
	@mkdir -p arxiv-submission
	@cp $(MAIN).tex arxiv-submission/
	@cp $(MAIN).bbl arxiv-submission/
	@cp arxiv.sty arxiv-submission/
	@if [ -d figures ]; then cp -r figures arxiv-submission/; fi
	@cd arxiv-submission && zip -r ../arxiv-submission.zip .
	@rm -rf arxiv-submission
	@echo "Created arxiv-submission.zip"
	@echo "Contents:"
	@unzip -l arxiv-submission.zip

clean-arxiv:
	rm -rf arxiv-submission arxiv-submission.zip

# Word count (approximate)
count:
	@texcount -inc -total $(MAIN).tex

# Check for common issues
check:
	@echo "Checking for common issues..."
	@grep -n "TODO" $(MAIN).tex || echo "No TODOs found"
	@grep -n "\\todo" $(MAIN).tex || echo "No \\todo commands found"
	@grep -n "FIXME" $(MAIN).tex || echo "No FIXMEs found"

.PHONY: all quick clean distclean arxiv clean-arxiv count check
