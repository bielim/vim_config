" General settings
runtime after/ftplugins/common.vim

" C specific settings
"
match ErrorMsg '\%>80v.\+'

set formatoptions-=o

" Insert a newline when wrapping a line
set formatoptions+=t

setlocal textwidth=79
" Highlight column 80
if v:version >= 700
    set colorcolumn=80
    highlight ColorColumn ctermbg=darkgrey
endif

let g:load_doxygen_syntax=1

" Settings for DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre=" \\brief              "
let g:DoxygenToolkit_paramTag_pre=" \\param[in,out]      "
let g:DoxygenToolkit_paramTag_postpost="\r*                      \r*"
let g:DoxygenToolkit_returnTag=" \\returns            "
let g:DoxygenToolkit_fileTag=" \\file"
let g:DoxygenToolkit_authorTag=" \\author           "
let g:DoxygenToolkit_dateTag=" \\date             "
let g:DoxygenToolkit_versionTag=" \\version          "
let g:DoxygenToolkit_undocTag="DOXYGEN_SKIP"
let g:DoxygenToolkit_classTag=" \\class"
let g:DoxygenToolkit_compactDoc="no"

