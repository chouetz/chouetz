"" VUNDLE
""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Monokai
Plugin 'lsdr/monokai'
"From vimAwesome
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'sheerun/vim-polyglot'
Plugin 'dense-analysis/ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"" SYNTASTIC
""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" DIFF PART
""""""""""""
"Setting monokai as default colorscheme for diffs
if &diff
  colorscheme monokai
endif

"Mapping for three ways merge
map ,2 "<ESC>:diffg LO<ENTER><ESC>:diffu<ENTER><ESC>"
map ,3 "<ESC>:diffg BA<ENTER><ESC>:diffu<ENTER><ESC>"
map ,4 "<ESC>:diffg RE<ENTER><ESC>:diffu<ENTER><ESC>"

"" DISPLAY PART
"""""""""""""""
"Display option
set number

"Indent and remove trailing chars before writing buffers
augroup cleanFileAtExit
   autocmd!
   autocmd BufWritePre * :%s/\s\+$//e
   autocmd BufWritePre *.c,*.h,*.cpp,*.hpp,Jenkins*,*.groovy :normal gg=G
augroup END

"Allow syntax coloration
syntax enable

"Define local leader for further config
let maplocalleader = "\\"
"Command to display constantly the current filename
set statusline=%f%m%r%h%w\ [Line=%04l/%04.8L]\ [%p%%]
set laststatus=2

"Configuring splits.
"Prefer split below with :split
set splitbelow
"Prefer split on the right with :vsplit
set splitright

"Highlight tab in current file
highlight TabLine ctermbg=Blue
match TabLine /\t/
"Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

inoremap jk <esc>
"Configure indentation
set autoindent
set smartindent
"No to the tabs !
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartcase
