TARGET := ict-brochure.pdf

BUILD_DIR := ./build
SRC_DIR := ./src
PDF_DIR := ./pdf

AUTOMATOR := automator
DOCX2PDF := ./bin/docx2pdf.app
PPTX2PDF := ./bin/pptx2pdf.app
LATEXMK := latexmk -pv -pdf

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
	cp $(TEXFILE:.tex=.pdf) $(TARGET)

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)
