# Makefile, see http://cgibbons.berkeley.edu/Research/Papers/MakefileTutorial.pdf

PODFILE=dancer-for-the-world
TEXFILE=dancer-for-the-world-beamer
INPUTS=dancer-for-the-world-beamer.tex dancer-for-the-world-de-beamer.tex
OUTPUTS=$(INPUTS:%.tex=%.pdf)

all: $(PODFILE).html $(OUTPUTS) clean

.PHONY: all clean

$(PODFILE).html: $(PODFILE).pod
	./pod2xhtml $(PODFILE).pod > $(PODFILE).html

$(OUTPUTS): %-beamer.pdf: %.tex
# initial run
	pdflatex $(<:%.tex=%-beamer.tex)

# run BibTeX if missing citations
	@if(grep "Citation" $(<:%.tex=%-beamer).log > /dev/null);\
    then \
        bibtext $(<:%.tex=%-beamer); \
		pdflatex $(<:%.tex=%-beame); \
    fi

# rerun if necessary
	@if(grep "Rerun" $(<:%.tex=%-beamer).log > /dev/null);\
    then \
		pdflatex $(<:%.tex=%-beamer); \
    fi

# Remove unnecessary files
clean:
	-rm -f *.log *.aux *.out *.blg *.bbl *.nav *.snm *.toc
