# Comment out to disable CJK support (use `pdflatex' instead of `xelatex')
#CJK:= ON

# Name to identify the reported manuscript
ID:= cdae-eor

DATE:=		$(shell date +'%Y%m%d')

# Environment variables
TEXINPUTS:=	.:mnras:revtex:texmf:$(TEXINPUTS)
BSTINPUTS:=	.:mnras:revtex:texmf:$(BSTINPUTS)

# Files to pack for submission
TEMPLATE:=	mnras/mnras.cls mnras/mnras.bst
SRCS:=		main.tex references.bib
FIGURES:=	figures/network-crop.pdf \
		figures/simudata.pdf \
		figures/cdae-train.pdf \
		figures/eor-result.pdf

default: main.pdf

report: main.pdf $(SRCS)
	@test -d "reports" || mkdir reports
	cp main.pdf reports/$(ID)-$(DATE).pdf
	cp main.tex reports/$(ID)-$(DATE).tex

main.pdf: $(SRCS) $(TEMPLATE) $(FIGURES)
ifeq ($(CJK),ON)
	# use XeLaTeX (support CJK)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) latexmk -xelatex $<
else
	# pdfLaTeX
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) latexmk -pdf $<
endif

submission: $(SRCS) $(TEMPLATE) $(FIGURES)
	mkdir $@.$(DATE)
	@for f in $(SRCS) $(TEMPLATE) $(FIGURES); do \
		cp -v $$f $@.$(DATE)/; \
	done
	tar -cf $@.$(DATE).tar -C $@.$(DATE)/ .
	rm -r $@.$(DATE)

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

.PHONY: report clean cleanall help
