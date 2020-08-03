" Melanie's vimrc

" Reload vimrc after it changed
autocmd! bufwritepost .vimrc source %

set nocompatible " turn on the 'IMproved' in VIM

"" Remap the <Leader> to '<space>'. This needs to be done before we load the plugins.
"let mapleader = "\<Space>"
"" Remap the <LocalLeader> (leader for a specific file type)
"let maplocalleader = ";"

" Plugins are now managed natively through git submodules in pack/plugins
" 
" * Julia support: https://github.com/JuliaEditorSupport/julia-vim.git
"
" * Smart replace https://github.com/tpope/vim-abolish.git 
"   (use %S/... instead of %s/...)

" Status line: https://github.com/vim-airline/vim-airline.git
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" https://github.com/preservim/nerdcommenter.git
let NERDCreateDefaultMappings=0       " disable default mappings
map <Leader>cc <plug>NERDCommenterAlignLeft
map <Leader>co <plug>NERDCommenterSexy
map <Leader>ci <plug>NERDCommenterUncomment

" https://github.com/Raimondi/delimitMate.git disabled (enable it in
" after/ftplugin/<type>.vim for specific file types)
let g:delimitMate_autoclose = 0

" LaTeX support
"Plugin 'lervag/vimtex'


" Load indentation rules according to the detected filetype.
filetype plugin indent on

" Syntax highlighting
syntax enable

" Encoding
set encoding=utf-8

" Key bindings
" Break out of insert mode using 'jk'
inoremap jk <Esc>

" The awesome/tmux/vim settings. Vim shortcuts starts with Ctrl:
" |         horizontal split
" _         vertical split
" h         go to left split
" j/k/l     go to ...
" H         swap with left split
" J/K/L     swap with ...
" u/i       go to left/right tab
" U/I       move to ...

" TODO: <C-\|> and <C-S-\\> don't seem to work
nnoremap \| <C-w><C-v>
nnoremap _ <C-w><C-s>
nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-S-h> <C-W><S-h>
nnoremap <C-S-j> <C-W><S-j>
nnoremap <C-S-k> <C-W><S-k>
nnoremap <C-S-l> <C-W><S-l>
nnoremap <C-u> gT
nnoremap <C-i> gt
" TODO: these here don't yet work
nnoremap <C-S-u> :tabm -1<CR>
nnoremap <C-S-i> :tabm +1<CR>


" General settings
set modeline " enable modelines
set isk+=_,$,@,%,#   " not-(word separators)
set ruler " show line and cursor positions
set noerrorbells " shut the fuck up!
set novisualbell " and don't blink either!
set vb
set showmatch  " show matching brackets
set showcmd             " Show (partial) command in status line.
set nowrapscan          " Avoid automatic wrapping (ensures we notice the 
                        " wrap, can still manually wrap using gg / G). 

" Searching
set hlsearch  " do not highlight searched for phrases
set incsearch  " BUT do highlight as you type you search phrase
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
" Ctrl-C clears the previous search's highlights
map <C-C> :noh<CR>

" Per project vim files
" This can be used to set tabstops, expandtab etc.
set exrc                " Load the .vimrc file in the current directory
set secure

" Scrolling
set scrolloff=10        " Keep cursor in the middle of the window

" ZSH like completion
set wildmenu
set wildmode=longest:full,full

" Coloring
set t_Co=256
set background=dark
colorscheme blackboard
" Search colors
hi Search guifg=#ffffff guibg=#0000ff gui=none ctermfg=white ctermbg=darkblue 
hi IncSearch guifg=#ffffff guibg=#8888ff gui=none ctermfg=white ctermbg=lightblue cterm=none 
"colorscheme default

" Spell checking
" F7 toggles spell checking for en_us and de_de
if v:version >= 700
    let b:myLang=0
    let g:myLangList=["nospell","en_us","de"]
    function! ToggleSpell()
        let b:myLang=b:myLang+1
        if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
        if b:myLang==0
            setlocal nospell
        else
            execute "setlocal spell spelllang=".get(g:myLangList,b:myLang)
        endif
        echo "spell checking language: " g:myLangList[b:myLang]
    endfunction
    if !exists("b:myLang")
      if &spell
        let b:myLang=index(g:myLangList,&spelllang)
      else
        let b:myLang=0
      endif
    endif

    nmap <silent> <F6> :call ToggleSpell()<CR>
    imap <F6> <C-o>:call MySpellLang()<CR>

endif

" Calling make
autocmd filetype cpp nnoremap <F5> :w <bar> exec '!make'<CR>
autocmd filetype tex nnoremap <F5> :w <bar> exec '!make'<CR>

" Search files recursively in path
let &path.=",**"

" Go to the directory of the file when opening
if v:version >= 720
    set autochdir
endif

" Line numbering
highlight LineNr ctermfg=lightgrey ctermbg=black
function CycleLineNumbers()
    if (&number == 1 && &relativenumber == 1)
       :set nonumber
       :set norelativenumber
    elseif (&number == 0 && &relativenumber == 0)
       :set number
    elseif (&number == 1 && &relativenumber == 0)
       :set relativenumber
    endif
endfunction
map <C-L> :call CycleLineNumbers()<CR>
set number


" Use an external text formater for explicit formating (using 'gq')
if executable('par-format')
    set formatprg=par-format\ -w76\ -rq
endif


" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Indenting
set ai " autoindent
set si " smart indent
" these tab settings are overwritten in indent/ and
" after/ for specific languages and code styles
set tabstop=4" displayed length of tabs
set softtabstop=4 " seems to be needed as well (~)
set shiftwidth=4 " governs auto indent, >> and << 
set expandtab " insert stofttabstop whitespaces
" This here is a bit of a mess, see 
"  http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
" a flag is a bit tedious over time
set formatoptions=crqwn2b " have the (internal) formatter be as smart as
                        " possible. It would be better to use += here but for
                        " some reason -=o doesn't work.

" Folding
set foldenable " turn it on
set foldmethod=syntax   " use the syntax files for folding
set foldlevel=20         " start folding at level 20
"set foldmethod=marker " use a special marker to do the folding
"set foldmarker={{{,}}} " use '{{{' to start and '}}}' to end a fold
"set foldlevelstart=0 " do fold by default

" 'updatetime' ms (default = 4sec) after cursor has been left unmoved
" (CursorHold), check whether the file has changed and offer to reload it
" (checktime).
au CursorHold * checktime

" Tabs and Splits (tmux: windows and panes)
set splitbelow
set splitright
autocmd VimResized * wincmd =


set tabstop=4 shiftwidth=2 expandtab


