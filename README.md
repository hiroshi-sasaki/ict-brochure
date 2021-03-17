# Brochure of the [ICT department at Tokyo Tech](https://educ.titech.ac.jp/ict/eng/)

## Structure
- `bin` contains the macOS Automator.app generated app files which convert the docx/pptx files to pdf files.
- `src` contains the original docx/pptx files.
- `pdf` contains the pdf files (of the corresponding docx files in the `src` directory) which are converted by the author of each file. The reason why we have this directory is because some docx files aren't rendered correctly in the following environment.

## Environment
The code is tested in the following environment:
- macOS Mojave (Version 10.14.6)
- Microsoft Word and PowerPoint for Mac (Version 16.45)
