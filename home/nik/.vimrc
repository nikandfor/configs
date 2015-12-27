

set nocompatible

set wildmenu
set wildmode=longest,list

set keywordprg=:help

set ruler
set scrolloff=5

colorscheme desert

set autoindent
set smartindent

set smarttab
set shiftround

set shiftwidth=4
set tabstop=4

set hls
set incsearch

set number

set nowrap

set noexpandtab


syntax on

set foldmethod=syntax

filetype plugin indent on

execute pathogen#infect()

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"

let g:go_fmt_fail_silently = 1

"let g:neocomplete#enable_at_startup = 1

nmap <F8> :TagbarToggle<CR>


let javaScript_fold=3 
let php_folding=1
let sh_fold_enabled=1
let vimsyn_folding='af'
let xml_syntax_folding=1

au BufNewFile,BufRead *.yaml,*yml source ~/.vim/syntax/yaml.vim
