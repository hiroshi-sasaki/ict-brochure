TARGET := ict-brochure.pdf

BUILD_DIR := ./build
SRC_DIR := ./src
PDF_DIR := ./pdf

AUTOMATOR := automator
DOCX2PDF := ./bin/docx2pdf.app
PPTX2PDF := ./bin/pptx2pdf.app
LATEXMK := latexmk -pv -pdf
# https://gist.github.com/firstdoit/6390547
# GS := gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH
# https://tbrink.science/blog/2018/05/13/lossy-compression-for-pdfs/
# GS := gs -dNOPAUSE -dQUIET -dBATCH -dSAFER -sDEVICE=pdfwrite -dPDFSETTINGS=/printer -dCompatibilityLevel=1.5 -dEmbedAllFonts=true -dSubsetFonts=true -dAutoRotatePages=/None
# http://www.alfredklomp.com/programming/shrinkpdf/
GS := gs -dNOPAUSE -dQUIET -dBATCH -dSAFER -sDEVICE=pdfwrite -dPDFSETTINGS=/printer -dCompatibilityLevel=1.5 -dEmbedAllFonts=true -dSubsetFonts=true -dAutoRotatePages=/None -dColorImageDownsampleType=/Bicubic -dColorImageResolution=120 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=120 -dMonoImageDownsampleType=/Subsample -dMonoImageResolution=120

SRCS := $(wildcard $(SRC_DIR)/*.docx) $(wildcard $(SRC_DIR)/*.pptx)
TEXFILE := main.tex

PDFS = $(patsubst $(SRC_DIR)/%.docx,$(BUILD_DIR)/%.pdf,$(SRCS:.pptx=.docx)) $(wildcard $(PDF_DIR)/*.pdf)

$(BUILD_DIR)/%.pdf: $(SRC_DIR)/%.docx
	mkdir -p $(dir $@)
	$(AUTOMATOR) -i $< $(DOCX2PDF)
	mv $(<:.docx=.pdf) $@

$(BUILD_DIR)/%.pdf: $(SRC_DIR)/%.pptx
	mkdir -p $(dir $@)
	$(AUTOMATOR) -i $< $(PPTX2PDF)
	mv $(<:.pptx=.pdf) $@

$(TARGET): $(TEXFILE) $(PDFS)
ifneq ($(wildcard $(PDF_DIR)/*),)
	cp -f $(PDF_DIR)/*.pdf $(BUILD_DIR)
endif
	$(LATEXMK) $(TEXFILE)
	$(GS) -sOutputFile=$(TARGET) $(TEXFILE:.tex=.pdf)

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)
