autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
let g:md_args = "--template eisvogel --pdf-engine=xelatex"
let g:md_pdf_viewer = "mupdf"
au BufWriteCmd *.md :AsyncTask file-build
