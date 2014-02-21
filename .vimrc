" IMPORTANT STUFF
" Forget being compatible with good ol' vi
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'mileszs/ack.vim'
Bundle 'dag/vim2hs'
Bundle 'Lokaltog/vim-powerline'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'altercation/vim-colors-solarized'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'msanders/snipmate.vim'
Bundle 'sontek/rope-vim'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'fs111/pydoc.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ujihisa/neco-ghc'
Bundle 'davidhalter/jedi-vim'
Bundle 'tpope/vim-git'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'xolox/vim-easytags'
Bundle 'kien/ctrlp.vim'
Bundle 'wincent/Command-T'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'xolox/vim-misc'


" Pathogen
"filetype off " Pathogen needs to run before plugin indent on
"call pathogen#infect()
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags() " generate helptags for everything in 'runtimepath'
"filetype off


if has ("gui_running")
    set lines=999 columns=999
endif


set visualbell

set laststatus=2
"set statusline=%t       "tail of the filename
"set statusline+=%m      "modified flag
"set statusline+=%{fugitive#statusline()}
"set statusline+=\ %P    "percent through file

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

"let g:neocomplcache_enable_at_startup = 1


" For fancy powerline symbols
let g:Powerline_symbols = 'fancy'
" Use a patched Ubuntu mono font
set guifont=Ubuntu\ Mono\ for\ Powerline\ 12


" FILETYPE
" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

set autoindent

" Turn on that syntax highlighting
syntax on


" THEME
syntax enable
set background=dark
colorscheme solarized


let g:pyflakes_use_quickfix = 0

let g:jedi#use_tabs_not_buffers = 0


" THA NUMBAHS AND MISC
set tabstop=8
set expandtab
set textwidth=79
set wrap
set formatoptions=qrn1
set colorcolumn=85
set softtabstop=4
set shiftwidth=4

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2

set foldmethod=indent
set foldlevel=99
set foldnestmax=2

set nu

set lbr

set undofile

set ttyfast

set autochdir

" Why is this not a default
set hidden

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu
set wildmode=list:longest



" LEADER STUFF
" instead of \
let mapleader = "\,"
let g:C_MapLeader  = '\,'

" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> ,ev :e $MYVIMRC<cr>

" And to source this file as well (mnemonic for the key sequence is
" 's'ource 'v'imrc)
nmap <silent> ,sv :so $MYVIMRC<cr>



" CURSOR STUFF
" Make command line two lines high
set ch=2

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" When the page starts to scroll, keep the cursor 8 lines from
" the top and 8 lines from the bottom
set scrolloff=5

" Allow the cursor to go in to "invalid" places
set virtualedit=onemore

set cursorline

" Enable Mouse
set mouse=a

" You can use :w!! to save as root
cmap w!! w !sudo tee % >/dev/null

set clipboard=unnamedplus


" SEARCH
" Incrementally match the search.
set incsearch
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %



" SUPERTAB
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" This assumes that ghc is in your path, if it is not, or you
" wish to use a specific version of ghc, then please change
" the ghc below to a full path to the correct one
au BufEnter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/google-chrome"
let g:ghc = "/usr/bin/ghc"



" HEX MODE STUFF
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
"vnoremap <C-H> :<C-U>Hexmode<CR>



" KEY-MAPPING
" jj goes to normal mode
inoremap jj <ESC>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

nmap <F2> :TagbarToggle<CR>

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"Save with ENTER in normal mode
nmap <Enter> :w <Enter>


" Allow pasting text without doing weird indentation
set pastetoggle=<F3>



" AUTO (AU)
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" save when focus is lost
"au FocusLost * :wa



" LEADER MAPPING
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

nmap <leader>a <Esc>:Ack!
let g:pep8_map='<leader>8'

" split vertically and switch to new window
nnoremap <leader>w <C-w>v<C-w>l

nmap <silent> <leader>n :NERDTreeToggle<CR>

map <leader>g :GundoToggle<CR>

map <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'

noremap <leader>cc :call NERDComment(0, "toggle")<CR>

set listchars=tab:>-,trail:○
set list
