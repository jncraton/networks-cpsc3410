SRC = index

all: $(SRC).html $(SRC).docx

.PHONY: clean

$(SRC).odt: readme.md
	pandoc --toc -o $@ $<

$(SRC).md: readme.md
	markdown-pp readme.md -o index.md

$(SRC).html: $(SRC).md
	pandoc --metadata pagetitle=Syllabs --standalone --css=style.css -o $@ $<

$(SRC).docx: $(SRC).md
	pandoc --metadata pagetitle=Syllabs --css=style.css -o $@ $<

$(SRC).tex: readme.md
	pandoc --mathjax --standalone --css=style.css -o $@ $<

$(SRC).pdf: readme.md
	pandoc --variable documentclass=article --variable fontsize=12pt --variable mainfont="FreeSans" --variable mathfont="FreeMono" --variable monofont="FreeMono" --variable monofontoptions="SizeFeatures={Size=8}" --include-in-head head.tex --no-highlight --mathjax --variable titlepage="false" -s -o $@ $< 

clean:
	rm -f $(SRC).txt $(SRC).odt $(SRC).docx $(SRC).pdf $(SRC).py $(SRC)-test.py $(SRC).html $(SRC).md slides.html
	rm -rf figures
	rm -rf __pycache__
	rm -f netlifyctl
	rm -rf revealjs
