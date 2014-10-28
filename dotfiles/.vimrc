syntax on
runtime mswin.vim
filetype plugin on
au filetype * setl nowrap
au filetype * let b:did_indent = 1
au filetype ruby setl sw=2 sts=2 ts=2

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

set wildmenu
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>
map <F5> "=strftime("%c")<CR>P

set autoindent
set autoread
set autowriteall
set backspace=2
set complete-=t
set clipboard=unnamed
set expandtab
set guioptions=c
set hidden
set history=100
set incsearch
set linebreak
set mouse=a
set nobackup
set nostartofline
set noswapfile
set wrap
set ruler
set shiftwidth=2
set showmode
set softtabstop=2
set tabstop=2
set undolevels=100
set mouse-=a
set modeline
set background=dark
set nobomb

if has("multi_byte")
   if &termencoding == ""
      let &termencoding = &encoding
   endif
   set encoding=utf-8
   setglobal fileencoding=utf-8 nobomb
   set fileencodings=ucs-bom,utf-8,latin1
endif

function! CleverTab() 
    if strpart(getline('.'), col('.') - 2 , 1) =~ '\w' | return "\<C-P>" | else | return "\<Tab>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

let g:user_zen_settings = {
\ 'indentation' : '  ',
\}
let g:user_zen_expandabbr_key = '<c-b>'
let g:use_zen_complete_tag = 1

"set ofu=syntaxcomplete#Complete
"set cindent
"set smartindent
"set autoindent
"set expandtab
"set tabstop=2
"set shiftwidth=2
