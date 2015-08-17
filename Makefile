LTX=note.ltx
LTXMAIN=$(basename $(LTX))
FMT=$(subst .ltx,.fmt,$(LTX))
PDF=$(subst .ltx,.pdf,$(LTX))
TEX=$(subst .ltx,.tex,$(LTX))
LOG=$(subst .ltx,.log,$(LTX))

default : $(PDF)

$(TEX) : $(LTX) $(FMT)
	lhs2TeX $(LTX) > $(TEX)

preview : $(PDF)
	@if [ `uname` = 'Darwin' ]; then \
	  open -a /Applications/Skim.app $(PDF); \
	else \
	  zathura $(PDF); \
	fi

$(PDF) : $(TEX)
	pdflatex -halt-on-error $(TEX)
	pdflatex -halt-on-error $(TEX)

clean :
	rm -f *.aux *.log *.nav *.out *.ptb *.toc *.snm $(PDF) $(TEX) *.synctex.gz *.bcf *.bbl *.blg *.run.xml
