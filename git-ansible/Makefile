# Makefile, see http://cgibbons.berkeley.edu/Research/Papers/MakefileTutorial.pdf

LATEX_BIN=xelatex
PODFILE=
TEXFILE=git-ansible
SLIDE_INPUTS=git-ansible-de-beamer.tex
SLIDE_OUTPUTS=$(SLIDE_INPUTS:%.tex=%.pdf)
HANDOUT_INPUTS=git-ansible-de-handout.tex
HANDOUT_OUTPUTS=$(HANDOUT_INPUTS:%.tex=%.pdf)
NOTES_INPUTS=git-ansible-de-notes.tex
NOTES_OUTPUTS=$(NOTES_INPUTS:%.tex=%.pdf)

all: $(SLIDE_OUTPUTS) $(HANDOUT_OUTPUTS) clean

.PHONY: all clean

$(PODFILE).html: $(PODFILE).pod
	./pod2xhtml $(PODFILE).pod > $(PODFILE).html

$(SLIDE_OUTPUTS): %-beamer.pdf: %.tex $(SLIDE_INPUTS)
# initial run
	$(LATEX_BIN) $(<:%.tex=%-beamer.tex)

# run BibTeX if missing citations
	@if(grep "Citation" $(<:%.tex=%-beamer).log > /dev/null);\
    then \
        bibtext $(<:%.tex=%-beamer); \
		$(LATEX_BIN) $(<:%.tex=%-beamer); \
    fi

# rerun if necessary
	@if(grep "Rerun" $(<:%.tex=%-beamer).log > /dev/null);\
    then \
		$(LATEX_BIN) $(<:%.tex=%-beamer); \
    fi

$(HANDOUT_OUTPUTS): %-handout.pdf: %.tex $(HANDOUT_INPUTS)
# initial run
	$(LATEX_BIN) $(<:%.tex=%-handout.tex)

# run BibTeX if missing citations
	@if(grep "Citation" $(<:%.tex=%-handout).log > /dev/null);\
    then \
        bibtext $(<:%.tex=%-handout); \
		$(LATEX_BIN) $(<:%.tex=%-handout); \
    fi

# rerun if necessary
	@if(grep "Rerun" $(<:%.tex=%-handout).log > /dev/null);\
    then \
		$(LATEX_BIN) $(<:%.tex=%-handout); \
    fi

$(NOTES_OUTPUTS): %-notes.pdf: %.tex $(NOTES_INPUTS)
# initial run
	$(LATEX_BIN) $(<:%.tex=%-notes.tex)

# run BibTeX if missing citations
	@if(grep "Citation" $(<:%.tex=%-notes).log > /dev/null);\
    then \
        bibtext $(<:%.tex=%-notes); \
		$(LATEX_BIN) $(<:%.tex=%-notes); \
    fi

# rerun if necessary
	@if(grep "Rerun" $(<:%.tex=%-notes).log > /dev/null);\
    then \
		$(LATEX_BIN) $(<:%.tex=%-notes); \
    fi

# Remove unnecessary files
clean:
	-rm -f *.log *.aux *.out *.blg *.bbl *.nav *.snm *.toc

# cleanup the pdf as well
distclean: clean
	-rm -f *.pdf
