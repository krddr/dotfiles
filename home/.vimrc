"
" .vimrc --
"
"    font:  Inconsolata (11pt)
"             http://packages.ubuntu.com/hardy/ttf-inconsolata
"             sudo apt-get install fonts-inconsolata
"           Liberation Mono (10pt)
"    color: solarized
"             https://github.com/altercation/vim-colors-solarized
"             https://github.com/Anthony25/gnome-terminal-colors-solarized
"             https://github.com/seebi/dircolors-solarized
"    color: jellybeans
"             https://github.com/nanotech/jellybeans.vim
"

" These suffixes take lower priority when matching.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Keep history across files, or something.
set viminfo='10,\"100,:20,%,n~/.viminfo

" Return to the same position in the file next time you open it.
if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" General look-and-feel stuff goes here.
set nostartofline
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set nomodeline
set ruler
set printoptions=paper:letter
set scrolloff=3         " Keep 3 lines when scrolling
set history=50          " Always keep the last 50 ':' commands
set novisualbell        " Turn off visual bell
set relativenumber      " Relative line numbers
set ignorecase          " Case insensitive searching
set hlsearch            " Highlight all matches in text search
set incsearch           " Jump to word as you search
set cursorline          " Highlight the current line

""" Format Help """

syntax on               " Always use syntax highlighting.

set smarttab            " Use shiftwidth for tabing and backspace.
set expandtab           " Turn tabs into spaces. Always.
set tabstop=3           " Use 3 spaces for each tab.
set shiftwidth=3        " Used for auto-indent and tabing.

set formatoptions=2ntcroqlv

" Ideal would be textwidth=80 for code and textwidth=72 for comments,
" but vim doesn't support different textwidth automatically. The script
" below also has side-effects. Instead only auto wrap comments and use
" the 72 character limit. If code goes beyond 80 chars we highlight
" in red below, so this is a good compromise.
set textwidth=72
set formatoptions-=t
" au CursorMovedI * if match(getline("\."),'^\s*\*') == 0|setlocal textwidth=72|else|setlocal textwidth=80|endif

""" C Format """

" Conform to some subtle standards guidlines that deal with alignment.
set cinoptions=g0,t0,c1s,(0,m1,l1
set cinwords+=case

" Overides for specific file types.
autocmd FileType java setlocal shiftwidth=4 tabstop=4

" Make sure block comments format nicely.
set comments=sl:/*,mb:\ *,elx:\ */

""" Errors """

" Highlight an error if the line is more than 80 chars. There are many
" possible ways to do this, but this has worked best for me.
au BufWinEnter *.c,*.h,*.cc,*.cpp,*.hh,*.hpp,*.py,*.pyw let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Replace tabs and trailing whitespace with something visible.
set list
set listchars=tab:›\ ,trail:·

""" Maps """

" Spell checking.
:map <F5> :setlocal spell! spelllang=en_us<CR>
:imap <F5> <C-o>:setlocal spell! spelllang=en_us<CR>

" Paste text mode; no autoformat.
nnoremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F6>
set showmode

" Center screen.
nmap <space> zz

" Leader mappings.
let mapleader=","
nnoremap <Leader>n :set invrelativenumber<CR>
nnoremap <Leader>l :set cursorline!<CR>
nnoremap <Leader>s :setlocal spell! spelllang=en_us<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>f :CtrlP<CR>
nnoremap <silent> <Leader>m :let &mouse = ( &mouse == "a" ? "" : "a" )<CR>
nnoremap <silent> <Leader>b :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
nnoremap <silent> <leader>c :set nolist!<CR>

" Move around more easily.
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" Ctrl-backspace kills one word backward.
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

""" Colors """

try
   colorscheme jellybeans
catch /^Vim\%((\a\+)\)\=:E185/
endtry

""" Plugins """

execute pathogen#infect()

"" Airline

"" Set airline preferences before the plugin loads.
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_theme = 'distinguished'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

function! CustomizePluginsLate()
   if exists('g:loaded_airline')
      set laststatus=2
      set noshowmode
   endif
endfunction

" Make some configuration changes after plugins have loaded.
autocmd VimEnter * call CustomizePluginsLate()

"" CtrlP

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"" vim-android

let g:android_sdk_path = '~/Android/Sdk'

