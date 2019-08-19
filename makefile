all: index.html syllabus.docx

.PHONY: clean

syllabus.md: readme.md
	markdown-pp $< -o $@

syllabus.html: syllabus.md
	pandoc --metadata pagetitle=Syllabus --standalone --css=style.css -o $@ $<

index.html: syllabus.html
	cp syllabus.html index.html

syllabus.docx: syllabus.md
	pandoc --metadata pagetitle=Syllabus --reference-doc reference.docx -o $@ $<

syllabus.pdf: syllabus.md
	pandoc --metadata title-meta=Syllabus --variable documentclass=article --variable fontsize=12pt --variable mainfont="FreeSans" --variable mathfont="FreeMono" --variable monofont="FreeMono" --variable monofontoptions="SizeFeatures={Size=8}" --include-in-head head.tex --no-highlight --mathjax --variable titlepage="false" -s -o $@ $< 

clean:
	rm -f index.html syllabus*
	rm -rf figures
	rm -rf __pycache__
	rm -f netlifyctl
	rm -rf revealjs
