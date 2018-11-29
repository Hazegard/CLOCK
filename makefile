LATEXMK=latexmk -g
LATEXMKOPT=-shell-escape
LATEXMKOUTPUT=-output-directory=build/
XELATEX=-xelatex

CLOCK=Clock
CLOCK_NOTES=Clock_notes
CLOCK_HANDOUT=Clock_handout
CLOCK_HANDOUT_NOTES=Clock_handout_notes

INPUT=000-Clock
C="\documentclass[aspectratio=1610, twocolumn]{beamer}\input{header}\\begin{document}\input{$(INPUT)}\\end{document}"
CH="\documentclass[aspectratio=1610, twocolumn, handout]{beamer}\input{header}\\begin{document}\input{$(INPUT)}\\end{document}"
CN="\documentclass[aspectratio=1610, twocolumn]{beamer}\input{header}\setbeameroption{show notes on second screen=right}\\begin{document}\input{$(INPUT)}\\end{document}"
CHN="\documentclass[aspectratio=1610, twocolumn, handout]{beamer}\input{header}\setbeameroption{show notes on second screen=right}\\begin{document}\input{$(INPUT)}\\end{document}"

BUILD_DIR=build/
OUTPUTDIR=docs/

MK=$(LATEXMK) $(XELATEX) $(LATEXMKOPT) $(LATEXMKOUTPUT)

PDF=$(CLOCK_NOTES)

all: $(CLOCK) $(CLOCK_HANDOUT) $(CLOCK_NOTES) $(CLOCK_HANDOUT_NOTES)

$(CLOCK):
	echo $(C) > $(CLOCK).tex
	$(MK) $(CLOCK)
	cp $(BUILD_DIR)$@.pdf $(OUTPUTDIR)$@.pdf
	rm $(CLOCK).tex

$(CLOCK_HANDOUT):
	echo $(CH) > $(CLOCK_HANDOUT).tex
	$(MK) $(CLOCK_HANDOUT)
	cp $(BUILD_DIR)$@.pdf $(OUTPUTDIR)$@.pdf
	rm $(CLOCK_HANDOUT).tex

$(CLOCK_NOTES):
	echo $(CN) > $(CLOCK_NOTES).tex
	$(MK) $(CLOCK_NOTES)
	cp $(BUILD_DIR)$@.pdf $(OUTPUTDIR)$@.pdf
	rm $(CLOCK_NOTES).tex

$(CLOCK_HANDOUT_NOTES):
	echo $(CHN) > $(CLOCK_HANDOUT_NOTES).tex
	$(MK) $(CLOCK_HANDOUT_NOTES)
	cp $(BUILD_DIR)$@.pdf $(OUTPUTDIR)$@.pdf
	rm $(CLOCK_HANDOUT_NOTES).tex

clean:
	rm -rf $(BUILD_DIR)*

PREPARE_CACHE:
	pdfpc -n right --persist-cache $(OUTPUTDIR)$(PDF).pdf

PRESENTATION_AND_COFEE:
	pdfpc -n right -d 20 --persist-cache $(OUTPUTDIR)$(PDF).pdf

PRESENTATION_CONDENSED:
	pdfpc -n right $(OUTPUTDIR)$(CLOCK_HANDOUT_NOTES).pdf
.PHONY: clean all PREPARE_CACHE CACHED_PRESENTATION
