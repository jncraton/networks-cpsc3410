all: index.html syllabus.html syllabus.docx syllabus.txt lectures/index.html

.PHONY: clean lectures

syllabus.md: readme.md
	markdown-pp $< -o $@

syllabus.txt: syllabus.md
	cp syllabus.md syllabus.txt

syllabus.html: syllabus.md
	pandoc -V lang=en --metadata pagetitle=Syllabus --standalone --css=style.css -o $@ $<

index.html: syllabus.md
	pandoc -V lang=en --metadata pagetitle=Syllabus --standalone --css=style.css -o $@ $<

syllabus.docx: syllabus.md
	pandoc -V lang=en --metadata pagetitle=Syllabus --reference-doc reference.docx -o $@ $<

syllabus.pdf: syllabus.md
	pandoc -V lang=en --metadata title-meta=Syllabus --variable documentclass=article --variable fontsize=12pt --variable mainfont="FreeSans" --variable mathfont="FreeMono" --variable monofont="FreeMono" --variable monofontoptions="SizeFeatures={Size=8}" --include-in-head head.tex --no-highlight --mathjax --variable titlepage="false" -s -o $@ $< 

lectures:
	find lectures -name "*.md" -exec pandoc --mathjax -t revealjs --standalone -V theme:white -V history=true --metadata pagetitle=Slides -o "{}.html" "{}" \;

spellcheck:
	for f in lectures/*.md; do aspell --home-dir=. --check --dont-backup "$$f"; done

lectures/all.md:
	rm -f lectures/all.md # This must be deleted, or it will be included in itself and hang the build
	cd lectures && sed -e '$$G' -s `ls -v *.md` > all.md

lectures/all.html: lectures/all.md
	pandoc -V lang=en --metadata pagetitle="Lecture Notes" --standalone --mathjax --css=../style.css -o $@ $<

lectures/all-slides.html: lectures/all.md
	pandoc --mathjax -t revealjs --standalone -V theme:white -V history=true --metadata pagetitle=Slides -o $@ $<

lectures/index.html: lectures lectures/all.html lectures/all-slides.html
	cd lectures && tree -H '.' -L 1 --noreport --charset utf-8 -P "*.html" > index.html

clean:
	rm -rf pandoc*
	rm -f index.html index.md syllabus*
	rm -rf lectures/*.html lectures/all.md
	find lectures -name "*.html" -exec rm -f {} \;
	rm -rf figures
	rm -rf __pycache__
	rm -f netlifyctl
	rm -rf revealjs
	rm -f readme-template.md
