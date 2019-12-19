

set nocompatible
filetype off

set wildmenu
set wildmode=longest,list

set keywordprg=:help

set ruler
set scrolloff=5

colorscheme nikanddesert
"au VimEnter *.* highlight Folded	cterm=bold ctermfg=blue ctermbg=NONE

"setlocal spell spelllang=en

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType s,S,asm setlocal ts=8 sts=8 sw=8 expandtab
autocmd FileType dart setlocal ts=2 sts=2 sw=2 noexpandtab
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab

au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

set indentkeys-=:

set autoindent
set smartindent

set smarttab
set shiftround

set shiftwidth=4
set tabstop=4

set hls
set incsearch

"set number

set nowrap

set noexpandtab


"syntax on

set foldmethod=syntax

"execute pathogen#infect()

" ***** Vundle *****
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'fatih/vim-go'

"Plugin 'Shougo/neocomplete'

"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/deoplete.nvim'
Plugin 'deoplete-plugins/deoplete-go', {'do': 'make'}
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'

Plugin 'nsf/gocode', {'rtp': 'vim/'}

" vim-codefmt
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'

Plugin 'ambv/black'

" clojure
Plugin 'VimClojure'

" dart
Plugin 'dart-lang/dart-vim-plugin'

" Solidity
Plugin 'tomlion/vim-solidity'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'ntpeters/vim-better-whitespace'

Plugin 'aklt/plantuml-syntax'
Plugin 'scrooloose/vim-slumlord'

call vundle#end()

" vim-codefmt
call glaive#Install()

augroup autoformat_settings
  "autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  "autocmd FileType python AutoFormatBuffer black
augroup END

autocmd BufWritePre *.py execute ':Black'

filetype plugin indent on

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
"let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_debug = 1

let g:go_def_mode = "gopls"

let g:go_fmt_command = "goimports"

let g:go_fmt_fail_silently = 1

let g:go_template_autocreate = 0
let g:go_template_use_pkg = 1

set autowrite
set completeopt=menu
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#enable_auto_select = 1

let javaScript_fold=3
let php_folding=1
let sh_fold_enabled=1
let vimsyn_folding='af'
let xml_syntax_folding=1

"syntastic
let g:syntastic_go_checker = ['go', 'golint', 'gotype', 'govet']


" dart
let dart_format_on_save = 1

"let g:go_auto_type_info = 1
"let g:go_auto_sameids = 1

let g:deoplete#sources#go#gocode_binary = '/home/nik/progrm/go/bin/gocode'

call deoplete#custom#option({
\ 'auto_complete_delay': 20,
\ 'smart_case': v:true,
\ 'max_list': 10,
\ 'max_menu_width': 200,
\ })

" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-go/gosnippets/snippets'

let g:deoplete#enable_at_startup = 1

let g:better_whitespace_enabled = 1


let g:slumlord_separate_win = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <F5> :<C-u>call <SID>build_go_files()<CR>
"autocmd FileType go nmap <F2> :GoImports<CR>
autocmd FileType go nnoremap <F3> :call GoFmtToggle()<cr>

set pastetoggle=<F2>
set showmode

function! GoFmtToggle()
	if (g:go_fmt_command=="gofmt")
		let g:go_fmt_command = "goimports"
	else
		let g:go_fmt_command = "gofmt"
	endif
	let g:go_fmt_command
endfunction

set path+=${GOPATH}/src

"autocmd FileType go nmap <F5> <Plug>(go-build)
