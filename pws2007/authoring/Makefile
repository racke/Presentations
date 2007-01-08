### Makefile --- 

# auxiliary variables

AUTHOR_ID = racke

# ----- Please don't modify the stuff below -----

TITLE = perlws-latex

VERSION = 1.03

MAIN = main

STYLES = perlws.sty

EXTRA_FILES = $(wildcard $(AUTHOR_ID)/*)

CLEANFILES = $(MAIN).{aux,toc,log,ind,ilg,idx} $(TGZTARGET) $(ZIPTARGET)

MAINTAINERCLEANFILES = $(MAIN).pdf $(MAIN).dvi $(MAIN).ps

MAINFILES = Makefile        \
            $(MAIN).ist     \
            $(EXTRA_FILES)  \
            $(STYLES)       \
            *.tex

DOCFILES = README README_EN HOWTO HOWTO_EN LICENSE

PPCD_FILES = $(wildcard indexlist_$(AUTHOR_ID)) \
             $(wildcard goodies_$(AUTHOR_ID)/*)

PREPARE4CD = prepare_for_cd.pl

TMPBASE = tmpdistaffezomtec

TMPSUBDIR = $(TITLE)-$(VERSION)

TMPDIR = $(TMPBASE)/$(TMPSUBDIR)

DISTFILES = $(MAINFILES) $(DOCFILES) $(PPCD_FILES) $(PREPARE4CD)

ZIPTARGET = $(TITLE)-$(VERSION).zip

TGZTARGET = $(TITLE)-$(VERSION).tgz

# for author distribution

MYTMPSUBDIR = $(TITLE)-$(AUTHOR_ID)

MYTMPDIR = $(TMPBASE)/$(MYTMPSUBDIR)

MYDISTFILES = article_$(AUTHOR_ID).tex \
              $(EXTRA_FILES) \
              $(PPCD_FILES)

MYZIPTARGET = $(TITLE)-$(AUTHOR_ID).zip

MYTGZTARGET = $(TITLE)-$(AUTHOR_ID).tgz

# commands
MAKEINDEX = makeindex -s $(MAIN).ist

# local targets
all-local: dvi ps pdf

clean:
	rm -f $(CLEANFILES)

maintainerclean: clean
	rm -f $(MAINTAINERCLEANFILES)

dist: zip

tgz:
	mkdir -p $(TMPDIR)
	tar cf - $(DISTFILES) | tar -C $(TMPDIR) -xf - 
	tar -C $(TMPBASE) -czf $(TGZTARGET) $(TMPSUBDIR)
	rm -fr $(TMPBASE)

zip:
	mkdir -p $(TMPDIR)
	tar cf - $(DISTFILES) | tar -C $(TMPDIR) -xf - 
	cd $(TMPBASE) ; zip -r ../$(ZIPTARGET) $(TMPSUBDIR)
	rm -fr $(TMPBASE)

mydist: myzip

mytgz:
	mkdir -p $(MYTMPDIR)
	tar cf - $(MYDISTFILES) | tar -C $(MYTMPDIR) -xf - 
	tar -C $(TMPBASE) -czf $(MYTGZTARGET) $(MYTMPSUBDIR)
	rm -fr $(TMPBASE)

myzip:
	mkdir -p $(MYTMPDIR)
	tar cf - $(MYDISTFILES) | tar -C $(MYTMPDIR) -xf - 
	cd $(TMPBASE) ; zip -r ../$(MYZIPTARGET) $(MYTMPSUBDIR)
	rm -fr $(TMPBASE)

pdf: $(MAIN).pdf

dvi: $(MAIN).dvi

ps: $(MAIN).ps

ppcd:
	perl $(PREPARE4CD) article_$(AUTHOR_ID).tex

# implicit rules

%.eps: %.png
	convert $< $@

%.pdf: %.dvi
	dvipdfm $<

%.ps: %.dvi
	dvips $<

%.zip: %.dvi
	zip $(MAIN).zip $(MAIN).pdf

%.dvi: %.tex
	(cd $(AUTHOR_ID) && ebb *png *jpg *pdf 2>/dev/null)
	latex $<
	$(MAKEINDEX) $(MAIN).idx
	latex $<
	latex $<

%.tex: %.pp
	pp2latex --prolog=prolog.inc $< | perl filter.pl > $@

# dependencies

$(MAIN).ps:  $(MAIN).dvi
$(MAIN).pdf: $(MAIN).dvi
$(MAIN).dvi: $(MAINFILES)

### Makefile ends here
