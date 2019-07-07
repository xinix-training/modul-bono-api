generate:
	pandoc --template template.tex --toc -V toc-title:"Daftar Isi" -o module-bono-api.pdf *.md
