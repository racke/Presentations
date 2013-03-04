# Makefile, see http://cgibbons.berkeley.edu/Research/Papers/MakefileTutorial.pdf

PODFILE=dancer-for-the-world
TEXFILE=dancer-for-the-world-beamer
INPUTS=dancer-for-the-world.tex

all: $(PODFILE).html $(TEXFILE).pdf clean

.PHONY: all clean

$(PODFILE).html: $(PODFILE).pod
	./pod2xhtml $(PODFILE).pod > $(PODFILE).html

$(TEXFILE).pdf: $(TEXFILE).tex $(INPUTS)
# initial run
	pdflatex $(TEXFILE)

# run BibTeX if missing citations
	@if(grep "Citation" $(TEXFILE).log > /dev/null);\
    then \
        bibtext $(TEXFILE); \
		pdflatex $(TEXFILE); \
    fi

# rerun if necessary
	@if(grep "Rerun" $(TEXFILE).log > /dev/null);\
    then \
		pdflatex $(TEXFILE); \
    fi

# Remove unnecessary files
clean:
	-rm -f *.log *.aux *.out *.blg *.bbl *.nav *.snm *.toc
