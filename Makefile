.PHONY: all pdf

all: paper-10190.html paper-10190.pdf

pdf: paper-10190.pdf

paper-10190.html: paper-10190.xml
	xsltproc -o $@ /usr/share/sgml/docbook/stylesheet/xsl/nwalsh/html/docbook.xsl $<

paper-10190.pdf: paper-10190.html
	htmldoc --webpage --outfile '$@' $<
