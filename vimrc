" Let VIM remember more history
set history=1000

" Enable filetype plugins
filetype plugin on
filetype indent on

" Auto read file when file changed from outside
set autoread

" Perform autoread everytime switch buffer or forcus on vim
au FocusGained,BufEnter * :silent! !

" Map leader for extra key combinations
let mapleader = "\<space>"
let g:mapleader = "\<space>"

" Faster saving
nmap <leader>w :w!<CR>

" Leave 7 lines of padding to top and bottom of editor when moving
set so=7

" Enable Wild menu, and ignore compiled files
set wildmenu
set wildignore=*.o,*~,*.pyc

" Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Buffer becomes hidden when it is abandoned instead of closed
set hid

" Always show the status line
set laststatus=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Configure left and right arrow key to behave correctly in vim
set whichwrap+=<,>,h,l,[,]

" Ignore source control files
set wildignore+=.git\*,.hg\*,.svn\*

" Enable mouse support, good for scrolling
if has('mouse')
  set mouse=a
endif

" Configure search to ignore case and behave like other editor
set smartcase
set hlsearch
set ignorecase
set incsearch

" Lazy redraw while execute macro, better performance
set lazyredraw
" Handle more character redraw, default is off when in tmux
set ttyfast

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" More natural split opening, like other text editor
set splitbelow
set splitright

" Set utf8 as std encoding and en_US as the standard lang
set encoding=utf8

" Use Unix as the standard file type, and mac as 2nd choice...
set ffs=unix,mac,dos

" Enable syntax highlighting
syntax enable

"""""""""""""""""""""""""
" Format the status line
"""""""""""""""""""""""""
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ [line:\ %l\/%L]\ \ %y\ \ [%{v:register}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Temporary files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off backup and swp
set nobackup
set nowb
set noswapfile

" Save undo files into a directory
set undodir=~/.vim_undodir
set undofile

" Use spaces instead of tabs
set expandtab

" Enable smarttab
set smarttab

" Set tab as 2 spaces (following Ruby community standard)
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Super usefull visual mode mapping for search
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap j gj

" Hack to clear last used search pattern
nnoremap <silent> <leader>/ :let @/="hey-vim-pleaseDisableHightlightNow"<CR>

" Quick recoding playback; Record with 'qq' (this disable the Ex mode)
nnoremap Q @q

" Quicker way to go between previous and next buffer
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>
nnoremap <silent> <leader>x :bdelete<CR>

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Remap VIM 0 to first non-blank character
nnoremap 0 ^

" Make shift-y to behave like shift-c and shift-d for yanking
nnoremap Y y$

" Deleting char with x will not overwrite content of the 0 register
nnoremap x "_x

" Faster edit & reload $MYVIMRC
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>re :so $MYVIMRC<CR>

"""""""""""""""""""""""""""""
" Filetype syntax mappings
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.config set filetype=xml
au BufRead,BufNewFile *.cshtml set filetype=html
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir

"""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" Toggle paste mode on and off
nnoremap <leader>pp :setlocal paste!<CR>

" Re-indent the entire file
nnoremap <leader>kd GVgg=

" Remove comments in Ruby's file
command! RemoveRubyComments :g/# /d
" Reduce empty lines to single
command! RemoveMultipleBlankLines %s/^\(\s*\n\)\+/\r
" Remove white spaces on none empty lines
command! RemoveTrailingWhiteSpace %s/\s\+$//
" Remove the Windows ^M - when the encodings gets messed up
command! RemoveWindowsMEncoding %s/^V^M/^V^M/g
" Replace all line ending to linux format
command! FixLineEndingToLinuxFormat %s/\r//g

""""""""""""""""""""""""""""""""""""""
" Usefull functions
""""""""""""""""""""""""""""""""""""""

" Helper function for visual selection related stuff
function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

""""""""""""""""""""""""""""""""""""""
" Configure plugins
""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" ctrl-n to behave like ctrl-d in sublime
Plug 'terryma/vim-multiple-cursors'

" gc - for commenting codes
Plug 'tpope/vim-commentary'

" normal mode - inside a surround - 'cs' to change surround, e.g. cs'"
" visual mode - selected text - 'S' to 'surround' of a text
Plug 'tpope/vim-surround'

call plug#end()

"""""""""""""""""""""""""""""""""""""
" => Plugins configurations
"""""""""""""""""""""""""""""""""""""

" Show NERDTree when vim starts
autocmd vimenter * NERDTree

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Configure NERDTree behavior when entering buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle NERDTree, similar with SublimeText or VS Code
" Let VIM remember more history
set history=1000

" Automatically read file when file changed from outside
set autoread

" Perform autoread everytime switch buffer or forcus on vim
au FocusGained,BufEnter * :silent! !

" Map leader for extra key combinations
let mapleader = "\<space>"
let g:mapleader = "\<space>"

" Faster saving
nmap <leader>w :w!<CR>

" Leave 7 lines of padding to top and bottom of editor when moving
set so=7

" Enable Wild menu, and ignore compiled files
set wildmenu
set wildignore=*.o,*~,*.pyc

" Always show current position
set ruler

" Always show the status line
set laststatus=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Configure left and right arrow key to behave correctly in vim
set whichwrap+=<,>,h,l,[,]

" Ignore source control files
set wildignore+=.git\*,.hg\*,.svn\*

" Enable mouse support, good for scrolling
if has('mouse')
  set mouse=a
endif

" Buffer becomes hidden when it is abandoned instead of closed
set hid

" Configure search to ignore case and behave like other editor
set smartcase
set hlsearch
set ignorecase
set incsearch

" Lazy redraw while execute macro, better performance
set lazyredraw
" Handle more character redraw, default is off when in tmux
set ttyfast

" Show matching brackets when text indicator is over them
set showmatch

" More natural split opening, like other text editor
set splitbelow
set splitright

" Set utf8 as std encoding and en_US as the standard lang
set encoding=utf8

" Use Unix as the standard file type, and mac as 2nd choice...
set ffs=unix,mac,dos

" Enable syntax highlighting
syntax enable

"""""""""""""""""""""""""
" Format the status line
"""""""""""""""""""""""""
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ [line:\ %l\/%L]\ \ %y\ \ [%{v:register}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Temporary files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off backup and swp
set nobackup
set nowb
set noswapfile

" Save undo files into a directory
set undodir=~/.vim_undodir
set undofile

" Use spaces instead of tabs
set expandtab

" Enable smarttab
set smarttab

" Set tab as 2 spaces (following Ruby community standard)
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Super usefull visual mode mapping for search
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap j gj

" Hack to clear last used search pattern
nnoremap <silent> <leader>/ :let @/="hey-vim-pleaseDisableHightlightNow"<CR>

" Quick recoding playback; Record with 'qq' (this disable the Ex mode)
nnoremap Q @q

" Goto next buffer
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<cr>

" Return to last edit position when opening files (You want this!)
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Remap VIM 0 to first non-blank character
nnoremap 0 ^

" Make shift-y to behave like shift-c and shift-d for yanking
nnoremap Y y$

" Deleting char with x will not overwrite content of the 0 register
nnoremap x "_x

" Faster reload $MYVIMRC
nmap <silent> <leader>re :so $MYVIMRC<CR>

"""""""""""""""""""""""""""""
" Filetype syntax mappings
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.config set filetype=xml
au BufRead,BufNewFile *.cshtml set filetype=html
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir

"""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" Toggle paste mode on and off
nnoremap <leader>pp :setlocal paste!<CR>

" Re-indent the entire file
nnoremap <leader>kd GVgg=

" Remove comments in Ruby's file
command! RemoveRubyComments :g/# /d
" Reduce empty lines to single
command! RemoveMultipleBlankLines %s/^\(\s*\n\)\+/\r
" Remove white spaces on none empty lines
command! RemoveTrailingWhiteSpace %s/\s\+$//
" Remove the Windows ^M - when the encodings gets messed up
command! RemoveWindowsMEncoding %s/^V^M/^V^M/g
" Replace all line ending to linux format
command! FixLineEndingToLinuxFormat %s/\r//g

""""""""""""""""""""""""""""""""""""""
" Usefull functions
""""""""""""""""""""""""""""""""""""""

" Helper function for visual selection related stuff
function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" ctrl-n to behave like ctrl-d in sublime
Plug 'terryma/vim-multiple-cursors'

" Comment out stuff in codes
" V, gc - Comment selected lines
" gc, gc - Comment current line
Plug 'tpope/vim-commentary'

" normal mode - inside a surround - 'cs' to change surround, e.g. cs'"
" visual mode - selected text - 'S' to 'surround' of a text
Plug 'tpope/vim-surround'

" Rails power tools
Plug 'tpope/vim-rails'

" Small wrapper around bundle
Plug 'tpope/vim-bundler'

" html5 autocomplete and syntax
Plug 'othree/html5.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""
" => Plugins' configurations
"""""""""""""""""""""""""""""""""""""

" Show NERDTree when vim starts
" autocmd vimenter * NERDTree

" Show NERDTree when vim starts when no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Configure NERDTree behavior when entering buffer
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" let g:NERDTreeMapActivateNode="<F3>"
" let g:NERDTreeMapPreview="<F4>"

" Toggle NERDTree, similar with SublimeText or VS Code
map <silent> <c-t> :NERDTreeToggle<CR>
" Show current file in NERDTree
map <silent> <F3> :NERDTreeFind<CR>
