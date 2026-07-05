source ~/.config/nvim/plugins.vim

syntax on

" All Plugins:
filetype off

"====[ Work out what kind of file this is ]========
filetype plugin indent on

au FocusLost * :wa

" Abbreviations
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter
abbr varialbe variable
abbr varaible variable
abbr covaraince covariance
abbr varaince variance

"set t_Co=256                " Explicitly tellim that the terminal supports 256 colors"
"colorscheme dracula         " Set the colorscheme"

" airline options
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#show_buffers = 0 " do not show open buffers in tabline
"let g:airline#extensions#tabline#show_splits = 0

"Set Stuff
set modelines=0

" Abbreviations
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter

"tabbing options
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"make vim not compatible with vi
set nocompatible
set autoread
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir

" if a mouse is available activate it in vim
if has('mouse')
set mouse=a
" set ttymouse=xterm2
endif

autocmd Filetype matlab setlocal commentstring=%%s

"set leader to <SPACE>
let mapleader=" "

" wipout buffer
nmap <silent> <leader>bw :bw<cr>
"open new empty buffer"
nmap <leader>T :enew<CR>
"Move to next buffer
nmap <leader>l :bnext<CR>
"Move to previous buffer
nmap<leader>h :bprevious<CR>
"Close current buffer and move to previous one
nmap <leader>bq :bp <BAR> bd#<CR>
"show all open buffers
nmap <leader>bl :ls<CR>

" shortcut to save
nmap <leader>, :w<cr>

"allows special search commands
nnoremap / /\v
vnoremap / /\v

"Set up smarter search behaviour
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

nnoremap <leader><space> :noh<cr>

map <leader>cl :call Latex()<cr>
map <C-n> :NERDTreeToggle<CR>

" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>

set wrap
set textwidth=80
set formatoptions=qrn1
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Show whitespace and tabs
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" Remove trailing whitespaces
nnoremap <silent> <Leader><BS> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:w<CR>

" move to begin/end of line
nnoremap K H
nnoremap J L
nnoremap H 0
nnoremap L $

"disable arrow keys to make it easier to learn vim
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"====[ Accelerated up and down on wrapped lines ]============
nnoremap j gj
nnoremap k gk

"====[ AUTOPAIRS ]
let g:AutoPairsShortcutFastWrap = '<M-l>'

"set f1 to have the same behaviour as ESC
noremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Set <C-c> to copy to clipboard
vnoremap <C-C> "+y

"matlab
let g:matlab_auto_mappings= 0
" let g:matlab_server_launcher = 'tmux'
" let g:matlab_server_split= 'horizontal'
set splitright
nnoremap <leader>m :MatlabCliOpenInMatlabEditor<CR>
nnoremap <leader>ms :MatlabLaunchServer<CR>
nnoremap <leader>mx :MatlabCliRunCell<CR>
vnoremap <leader>mx :<BS><BS><BS><BS><BS>MatlabCliRunSelection<CR>

nnoremap <leader>ev :e! ~/.config/nvim/init.vim<cr>
nnoremap <leader>ep :e! ~/.config/nvim/plugins.vim<CR>

imap <C-p> <Plug>IMAP_JumpForward
nmap <C-p> <Plug>IMAP_JumpForward
vmap <C-p> <Plug>IMAP_JumpForward

map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

imap jj <ESC>

vmap <Tab> >
vmap <S-Tab> <
nmap <Tab> >>
nmap <S-Tab> <<


" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

function! Latex()
    write
    :VimuxInterruptRunner
    call VimuxRunCommand("clear; make")
endfunction

" FZF
"""""""""""""""""""""""""""""""""""""

let g:fzf_layout = { 'down': '~25%' }

if isdirectory(".git")
    " if in a git project, use :GFiles
    nmap <silent> <leader>t :GFiles<cr>
else
    " otherwise, use :FZF
    nmap <silent> <leader>t :FZF<cr>
endif

nmap <silent> <leader>r :Buffers<cr>
nmap <silent> <leader>e :GFiles?<cr>
nmap <silent> <leader>w :FZF<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})


" Fugitive Shortcuts
"""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>


"PYTHON STUFF
let g:pymode_python = 'python3'
let pymode_rope_autoimport=1
