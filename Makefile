TEX=second-year-report.tex
TEXMAIN=$(basename $(TEX))
PDF=$(subst .tex,.pdf,$(TEX))
LOG=$(subst .tex,.log,$(TEX))
BIB=$(subst .tex,.bib,$(TEX))

default : $(PDF)

$(PDF) : $(TEX) $(BIB) macros.tex
	pdflatex -halt-on-error $(TEX)
	bibtex $(TEXMAIN)
	pdflatex -halt-on-error $(TEX)
	sh -c ' \
	  i=1; \
	  while [ $$i -lt 5 ] && ( \
	       grep -c "undefined citations" $(LOG) \
	    || grep -c "undefined references" $(LOG) ); \
	  do pdflatex -halt-on-error $(TEX); \
	     i=`expr $$i + 1`; \
	     done; \
          echo "Iterations: $$i"'

clean :
	rm -f *.aux *.log *.nav *.out *.ptb *.toc *.snm *.synctex.gz *.bbl *.blg $(PDF)
