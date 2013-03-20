# Makefile, see http://cgibbons.berkeley.edu/Research/Papers/MakefileTutorial.pdf

TEXFILE=dancer-beamer
INPUTS=dancer-beamer.tex dancer-de-beamer.tex
OUTPUTS=$(INPUTS:%.tex=%.pdf)

all: $(OUTPUTS); make clean

.PHONY: all clean

$(OUTPUTS): %-beamer.pdf: %.tex layout.pdf
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

layout.pdf: layout.xml layout.html
	flute --pdf=layout.pdf layout.xml layout.html 

# Remove unnecessary files
clean:
	-rm -f *.log *.aux *.out *.blg *.bbl *.nav *.snm *.toc
