" Let VIM remember more history
if &history < 1000
  set history=1000
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

if !empty(&viminfo)
  set viminfo^=!
endif

set sessionoptions-=options

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endi

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" Enable filetype plugins
filetype plugin on

"omni complate (default instal)"
set omnifunc=syntaxcomplete#Complete

if has("autocmd")
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif

" remap Ctrl-x Ctrl-o to Shift-Space
imap <S-Space> <C-x><C-o>

" Auto read file when file changed from outside
set autoread

set ttimeout
set ttimeoutlen=100

" Perform autoread everytime switch buffer or forcus on vim
" au FocusGained,BufEnter * :silent! !

" Map leader for extra key combinations
let mapleader = "\<space>"
let g:mapleader = "\<space>"

" Faster saving
nmap <leader>w :w!<CR>

" Leave 7 lines of padding to top and bottom of editor when moving
set so=7

" Enable Wild menu, and ignore compiled & binary files
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.tar.gz,~*,*.tar.bz2,*.rar,*.o,*.pyc,*.hg,*/cache/*
set wildignore+=*.bz,*.iso,*.o,*.obj,*.bak,*.exe,*.gz,*.jpeg,*.png,*.jpg,*.flw,*.mp4,*.tar,*.mp3,*.pdf,*.djvu

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
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

"""""""""""""""""""""""""
" Format the status line
"""""""""""""""""""""""""
set statusline=%{HasPaste()}\ %t%m%r%h%w\ %y\ \ enc:%{&enc}\ format:%{&ff}\ file:%{&fenc}\ %{fugitive#statusline()}%=\ (\ ch:%3b\ hex:%2B\ )\ col:%2c\ line:%2l/%L\ [%2p%%]

" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ [line:\ %l\/%L]\ \ %y\ \ [%{v:register}]


"""""""""""""""""""""""""""""""""""""""
" => Temporary files, backups and undo
"""""""""""""""""""""""""""""""""""""""
" Turn off backup and swp
set nobackup
set nowb
set noswapfile

" Save undo files into a directory
set undodir=~/.vim_undodir
set undofile

" Enable smarttab
set smarttab

" Set tab as 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""
" => Editing & mappings
"""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap j gj

" Hack to clear last used search pattern
nnoremap <silent> <leader>/ :let @/="hey-vim-pleaseDisableHightlightNow"<CR>

" Quick recoding playback; Record with 'qq' (this disable the Ex mode)
nnoremap Q @q

" Remap VIM 0 to first non-blank character
nnoremap 0 ^

" Make shift-y to behave like shift-c and shift-d for yanking
nnoremap Y y$

" Deleting char with x will not overwrite content of the 0 register
nnoremap x "_x

" Delete all before the cursor
inoremap <C-U> <C-G>u<C-U>

" Super usefull visual mode mapping for search
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Faster edit & reload $MYVIMRC
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>re :so $MYVIMRC<CR>

" - Start - DISABLE VISUAL PASTE TO OVERWRITE REGISTER
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction

" This supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()
" - End - DISABLE VISUAL PASTE TO OVERWRITE REGISTER

"""""""""""""""""""""""""""""""""""""""""
" => Buffers navigation
"""""""""""""""""""""""""""""""""""""""""

" Quicker way to go between previous and next buffer
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>

" Faster way to move between windows
nnoremap <silent> <C-j> <C-W><C-J>
nnoremap <silent> <C-k> <C-W><C-K>
nnoremap <silent> <C-h> <C-W><C-H>
nnoremap <silent> <C-l> <C-W><C-L>

" Close all other window
nnoremap <silent> <leader>o :only<CR>

" Delete current buffer
nnoremap <silent> <leader>x :bdelete<CR>

" Open netrw file explorer
nnoremap <silent> <leader>f :Explore<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>ee :e <c-r>=expand("%:p:h")<CR>/

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<cr>

" Close all buffers
nnoremap <silent> <leader>ba :bufdo bd<CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

nnoremap K :echo 'Shift-K: Nothing happened!'<CR>


"""""""""""""""""""""""""""""""""""""""""
" => Filetype syntax mappings
"""""""""""""""""""""""""""""""""""""""""
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
" => Usefull functions
""""""""""""""""""""""""""""""""""""""
function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
call plug#end()
endfunction

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

" Helper function for visual selection related stuff
function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

call plug#end()
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
        return '[PASTE MODE]'
    endif
    return ''
endfunction


""""""""""""""""""""""""""""""""""""""
" => Configure plugins
""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" ctrl-n to behave like ctrl-d in sublime
Plug 'terryma/vim-multiple-cursors'

" Comment out stuff in codes
" V, gc - Comment selected lines
" gc, gc - Comment current line
Plug 'tpope/vim-commentary'

" Enable repeating supported plugin to maps with '.'
Plug 'tpope/vim-repeat'

" normal mode - inside a surround - 'cs' to change surround, e.g. cs'"
" visual mode - selected text - 'S' to 'surround' of a text
Plug 'tpope/vim-surround'

" Add support to Ruby language
Plug 'vim-ruby/vim-ruby'

" Rails power tools
Plug 'tpope/vim-rails'

" Rails slim template engine support
Plug 'slim-template/vim-slim'

" Help auto input ending tag
Plug 'tpope/vim-endwise'

" Search for, substitute, and abbreviate multiple variants of a word 
Plug 'tpope/vim-abolish'

" Small wrapper around bundle
Plug 'tpope/vim-bundler'

" Best Git wrapper of all time
Plug 'tpope/vim-fugitive'

" html5 omnicomplete and syntax
Plug 'othree/html5.vim'


"""""""""""""""""""""""""""""""""""""
" => NERDTree configurations
"""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

let g:NERDTreeStatusline = "%{ getcwd() }"
let g:NERDTreeIgnore=['\.pyc', '\~$','\.chm*','\.exe*', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.iso', '\.tar$','\.pdf','\.rar$','\.doc$','\.docx','\.xls$','\.xlsx', '\.djvu$', '\.tar\.gz', '\.tar\.bz2', '.tar.bz', '\.jpg$', '\.jpeg$', '\.o$','\.mp3$' ]

" Toggle NERDTree, similar with SublimeText or VS Code
map <silent> <c-t> :NERDTreeToggle<CR>

" Show current file in NERDTree
map <silent> <F3> :NERDTreeFind<CR>


" ------------------------------------------
"  => CtrlP configs
" ------------------------------------------
Plug 'ctrlpvim/ctrlp.vim'

" Ctrl-M to show most resently edited files
nmap <silent> <leader>m :CtrlPMRUFiles<CR>

" CtrlP uses ag instead of ack
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif

" ------------------------------------------
"  => Ag configs
" ------------------------------------------
" Vim frontend for Ag - the_silver_searcher
Plug 'rking/ag.vim'

let g:ag_working_path_mode="r"
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP & respects rules in .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/](\.(git|hg|svn)|\Debug|\Release|node_modules|packages|jspm_packages|bower_components)$',
        \ 'file': '\v\.(exe|pyc|so|dll|class|map)$',
        \ }
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ag and put the cursor in the right position
nmap <leader>ag :Ag

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" To go to the next search result do:
map <leader>cn :cn<CR>

" To go to the previous search results do:
map <leader>cp :cp<CR>

" When you search with Ag, display your results in cope by doing:
map <leader>cc :botright cope<CR>
map <leader>co ggVGy:tabnew<CR>:set syntax=qf<cr>pg

call plug#end()
