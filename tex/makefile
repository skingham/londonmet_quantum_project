# Just a snippet to stop executing under other make(1) commands
# that won't understand these lines 
ifneq (,)
This makefile requires GNU Make.
endif

LATEX := xelatex
LATEX_FLAGS := -synctex=1 -interaction=nonstopmode --shell-escape -output-directory=$(PDF_DIR)
#-interaction=errorstopmode batchmode scrollmoder errorstopmode
PDF_DIR := pdf
TEX_DIR := tex

export TEXINPUTS=.:./tex//:

RPT_NAME := 21014912_MSc

PDF_FILES := \
	21014912_MSc_ProjectPlan.pdf \
	$(RPT_NAME).pdf

RPT_TEX_FILES := \
	tex/sections/introduction.tex

TEX_SRCS := $(shell find $(TEX_DIR) -maxdepth 3 -type f -regex ".*\.tex")

SRCS_TEX := $(addprefix $(TEX_DIR)/,$(PDF_FILES:=.pdf=.tex))
PDF_TARGETS := $(addprefix $(PDF_DIR)/,$(PDF_FILES))

LOCAL_STY :=$(TEX_DIR)/local_doc.sty
 
IND      := $(SRCS_TEX:.tex=.ind)
BBL      := $(SRCS_TEX:.tex=.bbl)
PDFS     := $(SRCS_TEX:.tex=.pdf)

LATEX_INTERMEDIATE := $(PDF_DIR)/

.PHONY: .FORCE tex-clean clean-bcf
.SECONDARY: $(addprefix $(PDF_DIR)/,$(PDF_FILES:=.pdf=.bcf)) $(addprefix $(PDF_DIR)/,$(PDF_FILES:=.pdf=.bbl)) $(addprefix $(PDF_DIR)/,$(PDF_FILES:=.pdf=.toc))
.FORCE:

$(PDF_DIR)/%.bbl: $(TEX_DIR)/references.bib
	biber --input-directory $(TEX_DIR) $(PDF_DIR)/$*.bcf

$(PDF_DIR)/%.bcf: $(TEX_DIR)/%.tex $(TEX_FILES)
	$(LATEX) $(LATEX_FLAGS) -output-directory=$(PDF_DIR) $*.tex

$(PDF_DIR)/%.toc: $(TEX_DIR)/%.tex $(TEX_FILES)
	$(LATEX) $(LATEX_FLAGS) -output-directory=$(PDF_DIR) $*.tex

$(PDF_DIR)/%.pdf: $(TEX_DIR)/%.tex $(PDF_DIR)/%.bcf $(PDF_DIR)/%.bbl $(PDF_DIR)/%.toc
	$(LATEX) $(LATEX_FLAGS) -output-directory=$(PDF_DIR) $*.tex

$(PDF_DIR)/$(RPT_NAME).pdf: $(TEX_DIR)/$(RPT_NAME).tex $(RPT_TEX_FILES)
	$(LATEX) $(LATEX_FLAGS) -output-directory=$(PDF_DIR) $(RPT_NAME).tex

$(PDF_DIR):
	mkdir $(PDF_DIR)

tex: $(PDF_TARGETS) $(PDF_DIR)

clean-bcf:
	-rm $(PDF_DIR)/*.bcf $(PDF_DIR)/*.blg

tex-clean:
	-rm $(PDF_DIR)/*.aux $(PDF_DIR)/*.bbl $(PDF_DIR)/*.blg $(PDF_DIR)/*.idx $(PDF_DIR)/*.ilg $(PDF_DIR)/*.ind $(PDF_DIR)/*.log $(PDF_DIR)/*.out $(PDF_DIR)/*.toc

distclean:
	-rm -f $(PDF_DIR)/*.aux $(PDF_DIR)/*.bbl $(PDF_DIR)/*.blg $(PDF_DIR)/*.idx $(PDF_DIR)/*.ilg $(PDF_DIR)/*.ind $(PDF_DIR)/*.log $(PDF_DIR)/*.out $(PDF_DIR)/*.pdf $(PDF_DIR)/*.toc

info:
	@echo "TEXINPUTS="$(TEXINPUTS)
	@echo "TEX_SRCS="$(TEX_SRCS)
	@echo $(RPT_TEX_FILES)
	@ls -l $(TEX_FILES) $(PDF_TARGETS)
