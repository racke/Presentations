# Makefile, see http://cgibbons.berkeley.edu/Research/Papers/MakefileTutorial.pdf

PODFILE=
TEXFILE=interchange6-beamer
SLIDE_INPUTS=interchange6-de-beamer.tex interchange6-training-en-beamer.tex
SLIDE_OUTPUTS=$(SLIDE_INPUTS:%.tex=%.pdf)
HANDOUT_INPUTS=interchange6-de-handout.tex interchange6-training-en-handout.tex
HANDOUT_OUTPUTS=$(HANDOUT_INPUTS:%.tex=%.pdf)

all: $(HANDOUT_OUTPUTS) $(SLIDE_OUTPUTS) clean

.PHONY: all clean

$(PODFILE).html: $(PODFILE).pod
	./pod2xhtml $(PODFILE).pod > $(PODFILE).html

$(SLIDE_OUTPUTS): %-beamer.pdf: %.tex
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

$(HANDOUT_OUTPUTS): %-handout.pdf: %.tex
# initial run
	pdflatex $(<:%.tex=%-handout.tex)

# run BibTeX if missing citations
	@if(grep "Citation" $(<:%.tex=%-handout).log > /dev/null);\
    then \
        bibtext $(<:%.tex=%-handout); \
		pdflatex $(<:%.tex=%-beame); \
    fi

# rerun if necessary
	@if(grep "Rerun" $(<:%.tex=%-handout).log > /dev/null);\
    then \
		pdflatex $(<:%.tex=%-handout); \
    fi

# Remove unnecessary files
clean:
	-rm -f *.log *.aux *.out *.blg *.bbl *.nav *.snm *.toc
