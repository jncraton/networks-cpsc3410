SRC = index

all: $(SRC).html $(SRC).pdf

.PHONY: show showpdf clean deploy

$(SRC).odt: $(SRC).md
	pandoc --toc -o $@ $<

$(SRC).html: $(SRC).md
	pandoc --mathjax --standalone --css=style.css -o $@ $<

$(SRC).tex: $(SRC).md
	pandoc --mathjax --standalone --css=style.css -o $@ $<

$(SRC).pdf: $(SRC).md
	pandoc --variable documentclass=article --variable fontsize=12pt --variable mainfont="FreeSans" --variable mathfont="FreeMono" --variable monofont="FreeMono" --variable monofontoptions="SizeFeatures={Size=8}" --include-in-head head.tex --no-highlight --mathjax --variable titlepage="false" --pdf-engine=xelatex -s -o $@ $< 

clean:
	rm -f $(SRC).txt $(SRC).odt $(SRC).docx $(SRC).pdf $(SRC).py $(SRC)-test.py $(SRC).html slides.html
	rm -rf figures
	rm -rf __pycache__
	rm -f netlifyctl
	rm -rf revealjs
