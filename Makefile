generate:
	pandoc --template src/templates/template.tex --toc -V toc-title:"Daftar Isi" -o dist/module-bono-api.pdf src/*.md
