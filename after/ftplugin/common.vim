" Common settings
"

" This doesn't work nicely with the way vim handles the formatting in comment 
" blocks (without trailing whitespace the next line is considered a new 
" paragraph)
"if has("autocmd")
"    " remove trailing whitespaces
"    autocmd BufWritePre * :%s/\s\+$//e
"endif
