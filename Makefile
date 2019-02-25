ID:=		cdae-eor

# Files to pack for submission
SRCS:=		main.tex references.bib
FIGURES:=	figures/network-crop.pdf \
		figures/obsimg-158.png \
		figures/simudata.pdf \
		figures/cdae-train.pdf \
		figures/eor-result.pdf \
		figures/eor-img-comp.png \
		figures/eor-ps-comp.png \
		figures/occlusion-fgeor.pdf \
		figures/cdae-train-noft.pdf
TEMPLATE:=	mnras/mnras.cls mnras/mnras.bst

TEXINPUTS:=	.:mnras:revtex:texmf:$(TEXINPUTS)
BSTINPUTS:=	.:mnras:revtex:texmf:$(BSTINPUTS)

DATE:=		$(shell date +'%Y%m%d')

default: main.pdf

report: main.pdf $(SRCS)
	@test -d "reports" || mkdir reports
	cp main.pdf reports/$(ID)-$(DATE).pdf
	cp main.tex reports/$(ID)-$(DATE).tex

main.pdf: $(SRCS) $(TEMPLATE) $(FIGURES)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) latexmk -xelatex $<

submission: $(SRCS) $(TEMPLATE) $(FIGURES)
	mkdir $@.$(DATE)
	@for f in $(SRCS) $(TEMPLATE) $(FIGURES) main.bbl README.txt; do \
		cp -v $$f $@.$(DATE)/; \
	done
	tar -czf $@.$(DATE).tar.gz -C $@.$(DATE)/ .
	rm -r $@.$(DATE)
	cp main.pdf $@.$(DATE).pdf

%-crop.pdf: %.pdf
	pdfcrop $^

clean:
	latexmk -c main.tex
	touch main.tex

cleanall:
	latexmk -C main.tex

help:
	@echo "default - compile the paper PDF file (main.pdf)"
	@echo "submission - pack the necessary files and figures for submission"
	@echo "clean - clean the temporary files"
	@echo "cleanall - clean temporary files and the output PDF file"

.PHONY: report clean cleanall help submission
