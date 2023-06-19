LATEX   = pdflatex

SRC = ${wildcard src/*.tex}

paper.pdf:  paper.tex $(SRC)
	$(LATEX) paper
	- bibtex paper
	$(LATEX) paper
	$(LATEX) paper

clean:
	$(RM)  $(PACKAGE).cls *.log *.aux *.pdf \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi
