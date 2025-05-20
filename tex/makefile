# Just a snippet to stop executing under other make(1) commands
# that won't understand these lines 
ifneq (,)
This makefile requires GNU Make.
endif

export TEXINPUTS=.:./tex//:
export TEXMF_OUTPUT_DIRECTORY=./pdf

PDF_DIR := pdf
TEX_DIR := tex

BIBTEX := biber
BIBTEX_FLAGS := --input-directory $(TEX_DIR)
MKIDX := makeindex
MKIDX_FLAGS :=
LATEX := xelatex
LATEX_FLAGS := -synctex=1 -interaction=nonstopmode --shell-escape -output-directory=$(PDF_DIR)
#-interaction=errorstopmode batchmode scrollmoder errorstopmode
RM := rm

RPT_NAME := 21014912_msc_quantum_dissertation

PDF_FILES := \
	21014912_msc_discussion_topics.pdf \
	21014912_msc_project_proposal.pdf \
	21014912_msc_quantum_dissertation.pdf \
	21014912_msc_quantum_dissertation_final.pdf \
	$(RPT_NAME).pdf

RPT_TEX_SRCS := \
	tex/21014912_msc_quantum_dissertation.tex \
	tex/sections/0.abstract.tex \
	tex/sections/1.introduction.tex \
	tex/sections/1.introduction_2.tex \
	tex/sections/2.survey_and_comparative_analysis.tex \
	tex/sections/2.background_and_topic_justification.tex \
	tex/sections/3.algorithm_roadmap.tex \
	tex/sections/4.learning_outcomes.tex \
	tex/sections/5.conclusion.tex \
	tex/sections/a.week1.tex \
	tex/sections/a.syllabus_flow.tex \
	tex/sections/a.outreach.tex

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

$(PDF_DIR)/%.bbl: .FORCE
	$(LATEX) $(LATEX_FLAGS) $*.tex
	$(BIBTEX) $(BIBTEX_FLAGS) $(PDF_DIR)/$*.bcf

$(PDF_DIR)/%.ind: .FORCE
	$(LATEX) $(LATEX_FLAGS) $*.tex
	$(MKIDX) $(MKIDX_FLAGS) $(PDF_DIR)/$*.idx

$(PDF_DIR)/%.pdf: $(TEX_DIR)/%.tex $(TEX_SRCS) $(PDF_DIR)/%.bbl $(PDF_DIR)/%.ind
	$(LATEX) $(LATEX_FLAGS) $< ; (rc=$$? && [[ $$rc == 0 ]] && echo "OK")

$(PDF_DIR)/$(RPT_NAME).pdf: $(TEX_SRCS) $(PDF_DIR)/$(RPT_NAME).bbl $(PDF_DIR)/$(RPT_NAME).ind
	$(LATEX) $(LATEX_FLAGS) $(TEX_DIR)/$(RPT_NAME).tex ; (rc=$$? && [[ $$rc == 0 ]] && echo "OK")

tex: $(PDF_TARGETS)

tex-clean:
	@-$(RM) -f $(PDF_DIR)/*.pdf

clean-bcf:
	@-$(RM) -q $(PDF_DIR)/*.bcf $(PDF_DIR)/*.blg $(PDF_DIR)/*.bbl

tex-dist-clean: tex-clean clean-bcf
	@-$(RM) -rf $(PDF_DIR)/*

info:
	@echo "TEXINPUTS="$(TEXINPUTS)
	@echo "TEX_SRCS="$(TEX_SRCS)
	@echo "RPT_TEX_SRCS="$(RPT_TEX_SRCS)
	@echo $(RPT_TEX_FILES)
	@ls -l $(TEX_FILES) $(PDF_TARGETS)
