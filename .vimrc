
if !1 | finish | endif

set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp

set fileformats=unix,dos,mac

set ignorecase
set smartcase

set nobackup

set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab
set autoindent
set backspace=indent,eol,start
set wrapscan
set showmatch
set wildmenu
set formatoptions+=mM

set whichwrap +=h
set whichwrap +=l

set ruler
set wrap
set laststatus=2
set cmdheight=2
set showcmd
set title

set display=lastline 
set pumheight=10

set autoread

let g:mapleader = ","

noremap \ ,

nnoremap Y y$


""
"" plugins
""
if &compatible
    set nocompatible
endif
set runtimepath^=~/.vim/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('altercation/vim-colors-solarized')
call dein#add('vim-jp/cpp-vim')
call dein#add('kana/vim-smartinput')
call dein#add('itchyny/lightline.vim')
call dein#add('w0ng/vim-hybrid')
call dein#add('cocopon/lightline-hybrid.vim')
call dein#add('tpope/vim-surround')
call dein#add('Rip-Rip/clang_complete', {'on_ft': ['c', 'cpp']})
call dein#add('rust-lang/rust.vim')
call dein#add('racer-rust/vim-racer')
call dein#add('lervag/vimtex')
call dein#add('thinca/vim-quickrun')

call dein#end()


"" clang complete
let g:clang_complete_auto = 1
let g:clang_auto_select = 0
let g:clang_use_library = 1

let g:clang_library_path='/usr/lib'
let g:clang_user_options='-std=c++14'

let g:clang_close_preview=1

filetype plugin indent on
filetype indent on
syntax on
syntax enable

""
""
""
noremap j gj
noremap k gk


""
"" include path
""


""
"" unite
""
let g:unite_enable_start_insert=0
noremap <C-P> :Unite buffer<CR>
noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <C-Z> :Unite file_mru<CR>

nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


""
"" vimfiler
""
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

nnoremap <silent> <Leader>fe :<C-u>VimFilerBuffer -quit<CR>
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -no-quit<CR>


" neocomplete
"let g:acp_enableAtStartup = 0
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = "\*ku\*"

""
"" smartinput
""
call smartinput#map_to_trigger('i', '<BS>', '<BS>', '<BS>')
call smartinput#define_rule({
    \ 'at'    : '(\%#)',
    \ 'char'  : '<BS>',
    \ 'input' : '<Del><BS>',
    \ })

call smartinput#define_rule({
    \ 'at'    : '{\%#}',
    \ 'char'  : '<BS>',
    \ 'input' : '<Del><BS>',
    \ })

call smartinput#define_rule({
    \ 'at'    : '\[\%#\]',
    \ 'char'  : '<BS>',
    \ 'input' : '<Del><BS>',
    \ })

call smartinput#define_rule({
    \ 'at'       : '<\%#>',
    \ 'char'     : '<BS>',
    \ 'input'    : '<Del><BS>',
    \ 'filetype' : ['cpp'],
    \ })

call smartinput#map_to_trigger('i', '*', '*', '*')
call smartinput#define_rule({
    \ 'at'       : '\/\%#',
    \ 'char'     : '*',
    \ 'input'    : '**/<Left><Left>',
    \ 'filetype' : ['c', 'cpp'],
    \ })

call smartinput#define_rule({
    \ 'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
    \ 'char'     : '{',
    \ 'input'    : '{};<Left><Left>',
    \ 'filetype' : ['cpp'],
    \ })

call smartinput#map_to_trigger('i', '<', '<', '<')
call smartinput#define_rule({
    \ 'at'       : '\<template\>\s*\%#',
    \ 'char'     : '<',
    \ 'input'    : '<><Left>',
    \ 'filetype' : ['cpp'],
    \ })
call smartinput#define_rule({
    \ 'at'       : '<\%#>',
    \ 'char'     : '<BS>',
    \ 'input'    : '<Del><BS>',
    \ 'filetype' : ['cpp'],
    \ })

""
"" VimShell
""
nnoremap <silent><Leader>vs :<C-u>VimShell -split-command=vsplit<CR>
nnoremap <silent><Leader>vc :<C-u>VimShellSendString<Space>
let g:vimshell_user_prompt = 'getcwd()'

""
"" vimtex
""
"let g:vimtex_latexmk_callback = 0
"let g:tex_flavor = 'latex'
let g:vimtex_enabled = 0
"let g:vimtex_latexmk_options = '-pdfdvi'
"let g:vimtex_imaps_enabled = 0

set background=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid
" must
set t_Co=256

let g:lightline = {}
let g:lightline.colorscheme = 'hybrid'

" rust
"
let g:rustfmt_autosave = 1
let g:rustfmt_command = '~/.cargo/bin/rustfmt'
set hidden
let g:racer_cmd = '~/.cargo/bin/racer'
let $RUST_SRC_PATH='/home/suibaka/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'


" 
" quickrun
"
"let g:quickrun_config = get(g:, 'quickrun_config', {})
"let g:quickrun_config._ = {
"    \ 'outputter' : 'error',
"    \ 'outputter/error/success' : 'buffer',
"    \ 'outputter/error/error' : 'quickfix',
"    \ 'outputter/quickfix/open_cmd' : "copen",
"    \ 'runner' : 'vimproc',
"    \ 'runner/vimproc/updatetime' : 500
"    \ }
"let g:quickrun_config.cpp = {
"    \ 'command' : 'g++',
"    \ 'cmdopt' : '-o a.out -std=c++14 -Wall -O2',
"    \ 'hook/time/enable' : 1
"    \ }
"
"nnoremap <expr><silent> <C-c> quickrun#is_running() ?
"quickrun#sweep.sessions() : '\<C-c>'
