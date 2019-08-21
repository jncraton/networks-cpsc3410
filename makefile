all: index.html syllabus.html syllabus.docx syllabus.txt lectures

.PHONY: clean lectures

syllabus.md: readme.md
	markdown-pp $< -o $@

syllabus.txt: syllabus.md
	cp syllabus.md syllabus.txt

syllabus.html: syllabus.md
	pandoc --metadata pagetitle=Syllabus --standalone --css=style.css -o $@ $<

index.md: formats.md syllabus.md 
	cat formats.md syllabus.md > index.md

index.html: index.md
	pandoc --metadata pagetitle=Syllabus --standalone --css=style.css -o $@ $<

syllabus.docx: syllabus.md
	pandoc --metadata pagetitle=Syllabus --reference-doc reference.docx -o $@ $<

syllabus.pdf: syllabus.md
	pandoc --metadata title-meta=Syllabus --variable documentclass=article --variable fontsize=12pt --variable mainfont="FreeSans" --variable mathfont="FreeMono" --variable monofont="FreeMono" --variable monofontoptions="SizeFeatures={Size=8}" --include-in-head head.tex --no-highlight --mathjax --variable titlepage="false" -s -o $@ $< 

lectures:
	find lectures -name "*.md" -exec pandoc --mathjax -t revealjs --standalone -V revealjs-url="https://revealjs.com" -o "{}.html" "{}" \;
	cd lectures && tree -H '.' -L 1 --noreport --charset utf-8 > index.html

clean:
	rm -f index.html syllabus*
	rm -rf lectures/*.html
	rm -rf figures
	rm -rf __pycache__
	rm -f netlifyctl
	rm -rf revealjs
	rm -f readme-template.md
