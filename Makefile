# Comment out to disable CJK support (use `pdflatex' instead of `xelatex')
#CJK:= ON

# Name to identify the reported manuscript
ID:= lwt

DATE:=		$(shell date +'%Y%m%d')

# Environment variables
TEXINPUTS:=	.:mnras:revtex:texmf:$(TEXINPUTS)
BSTINPUTS:=	.:mnras:revtex:texmf:$(BSTINPUTS)

# EPS figures
EPS_FIG:=	$(wildcard figures/*.eps)
PDF_FIG:=	$(EPS_FIG:.eps=.pdf)

# Files to pack for submission
SRCS:=		main.tex references.bib
FIGURES:=	figures/network-crop.pdf
TEMPLATE:=	mnras/mnras.cls mnras/mnras.bst

default: main.pdf

eps2pdf: $(PDF_FIG)

report: main.pdf $(SRCS)
	-mkdir reports
	mkdir reports/v$(DATE)
	cp main.pdf reports/v$(DATE)/manuscript-$(ID)-$(DATE).pdf
	cp main.tex reports/v$(DATE)/manuscript-$(ID)-$(DATE).tex
	cp references.bib reports/v$(DATE)/references-$(ID)-$(DATE).bib

main.pdf: $(SRCS) $(TEMPLATE) $(FIGURES) eps2pdf
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

%.pdf: %.eps
	epstopdf $^ $@

%-crop.pdf: %.pdf
	pdfcrop $^

clean:
	latexmk -c main.tex
	touch main.tex

cleanall:
	latexmk -C main.tex

help:
	@echo "default - compile the paper PDF file (main.pdf)"
	@echo "eps2pdf - convert figures from EPS to PDF"
	@echo "submission - pack the necessary files and figures for submission"
	@echo "clean - clean the temporary files"
	@echo "cleanall - clean temporary files and the output PDF file"

.PHONY: report clean cleanall help
