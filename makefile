SRC = index

all: $(SRC).html syllabus.docx

.PHONY: clean

$(SRC).odt: $(SRC).md
	pandoc --toc -o $@ $<

$(SRC).md: readme.md
	markdown-pp readme.md -o index.md

syllabus.html: $(SRC).md
	pandoc --metadata pagetitle=Syllabus --standalone --css=style.css -o $@ $<

index.html: syllabus.html
	cp syllabus.html index.html

syllabus.docx: $(SRC).md
	pandoc --metadata pagetitle=Syllabus --reference-doc reference.docx -o $@ $<

syllabus.tex: $(SRC).md
	pandoc --mathjax --standalone --css=style.css -o $@ $<

syllabus.pdf: $(SRC).md
	pandoc --metadata title-meta=Syllabus --variable documentclass=article --variable fontsize=12pt --variable mainfont="FreeSans" --variable mathfont="FreeMono" --variable monofont="FreeMono" --variable monofontoptions="SizeFeatures={Size=8}" --include-in-head head.tex --no-highlight --mathjax --variable titlepage="false" -s -o $@ $< 

clean:
	rm -f $(SRC).txt $(SRC).odt $(SRC).docx $(SRC).pdf $(SRC).py $(SRC)-test.py $(SRC).html $(SRC).md syllabus* slides.html
	rm -rf figures
	rm -rf __pycache__
	rm -f netlifyctl
	rm -rf revealjs
