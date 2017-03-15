" author: togra93
" last-updated: 2017-03-15
" configuration of vim

let mapleader=","       " leader is comma
colorscheme desert
syntax enable           " enable syntax processing
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in TAB when editing
set expandtab           " tabs are spaces
set number              " show line numbers
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indet files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching brackets
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
