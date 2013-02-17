# Makefile, see http://cgibbons.berkeley.edu/Research/Papers/MakefileTutorial.pdf

TEXFILE=dancer-for-the-world-beamer
INPUTS=dancer-for-the-world.tex

all: $(TEXFILE).html; $(TEXFILE).pdf; make clean

.PHONY: all clean

$(TEXFILE).html: $(TEXFILE).pod
	pod2html $(TEXFILE).pod

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
