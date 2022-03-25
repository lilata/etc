set nocompatible
set autoread
let mapleader="\<Space>"
" wildmenu
set wildmenu "display tab complete options in menu
set wildmode=list:longest
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**
" backspace
set backspace=indent,eol,start    " Intuitive backspacing.
" clipboard
set clipboard=unnamedplus         " Alias unnamed register to the + register, which is the X Window clipboard.
set ttyfast
set softtabstop=2
set shiftwidth=4
set tabstop=4
syntax on
set autoindent
set synmaxcol=1024 " Syntax coloring lines that are too long just slows down the world
set smartindent
set expandtab
set number
set relativenumber
set nobackup
set lazyredraw
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set visualbell
set notitle
set nofoldenable

if has('nvim')
    let $VIMHOME = $HOME.'/.config/nvim'
    let $VIMDATA = $HOME.'/.local/share/nvim'
else
    let $VIMHOME = $HOME.'/.vim'
    let $VIMDATA = $HOME.'/.local/share/vim'
endif

" Highlight the current line and column
set nocursorline
set nocursorcolumn
" Move in windows
map <Leader>ww :wincmd w<cr>
map <Leader>wh :wincmd h<cr>
map <Leader>wj :wincmd j<cr>
map <Leader>wk :wincmd k<cr>
map <Leader>wl :wincmd l<cr>
map <Leader>wo :only<cr>
map <Leader>wq :wq<cr>
map <Leader>q :q<cr>
" Reduce timeout for key codes
set timeout timeoutlen=800 ttimeoutlen=0
" tab navigation
nnoremap <C-t> :tabnext<CR>
" search
set incsearch
" set hlsearch
set showmatch
set wrapscan
" set autochdir " change dir for netrw

nnoremap <silent> <Leader>cw :set nowrap!<CR>
nnoremap <silent> <Leader>ch :set hlsearch!<CR>

" UI
set background=dark

" silent !mkdir -p $VIMDATA."/undodir"
call mkdir($VIMDATA.'/undodir', "p", 0700)
let &undodir=$VIMDATA."/undodir"
set undofile

nnoremap J :bprev<CR>
nnoremap K :bnext<CR>

" auto open brackets
inoremap {<CR> {<CR>}<C-o>O

runtime macros/matchit.vim

filetype plugin indent on
filetype plugin on


" Make "." work with every line selected in the visual mode
vnoremap . :normal.<CR>
" Move visual selection directly
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Use relative number only in normal mode
augroup toggle_relative_number
	autocmd InsertEnter * :setlocal norelativenumber
	autocmd InsertLeave * :setlocal relativenumber

" White space
match ErrorMsg '\s\+$' " match
autocmd BufWritePre * :%s/\s\+$//e " auto delete

" keep the cursor in the middle of the screen
nnoremap j jzz
nnoremap k kzz
filetype off


" for html
nnoremap <silent> <c-i> vit<ESC>
" nnoremap <silent> <c-i> vat

""" netrw
let g:netrw_altv=1
" absolute width of netrw window
let g:netrw_winsize = -28
" do not display info on the top of window
let g:netrw_banner = 0
" tree-view
let g:netrw_liststyle = 3
" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'
" use the previous window to open file
let g:netrw_browse_split = 4


" Toggle Lexplore with Ctrl-E
map <silent> <c-e> :Lexplore<CR>

" better Lexplore
com!  -nargs=* -bar -bang -complete=dir  Lexplore  call netrw#Lexplore(<q-args>, <bang>0)

fun! Lexplore(dir, right)
  if exists("t:netrw_lexbufnr")
  " close down netrw explorer window
  let lexwinnr = bufwinnr(t:netrw_lexbufnr)
  if lexwinnr != -1
    let curwin = winnr()
    exe lexwinnr."wincmd w"
    close
    exe curwin."wincmd w"
  endif
  unlet t:netrw_lexbufnr

  else
    " open netrw explorer window in the dir of current file
    " (even on remote files)
    let path = substitute(exists("b:netrw_curdir")? b:netrw_curdir : expand("%:p"), '^\(.*[/\\]\)[^/\\]*$','\1','e')
    exe (a:right? "botright" : "topleft")." vertical ".((g:netrw_winsize > 0)? (g:netrw_winsize*winwidth(0))/100 : -g:netrw_winsize) . " new"
    if a:dir != ""
      exe "Explore ".a:dir
    else
      exe "Explore ".path
    endif
    setlocal winfixwidth
    let t:netrw_lexbufnr = bufnr("%")
  endif
endf

""""""" START PLUG
if filereadable($VIMHOME . '/autoload/plug.vim')
    call plug#begin($VIMDATA . '/plugged')
    Plug 'tpope/vim-surround'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'mattn/emmet-vim'

    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    call plug#end()
    " emmet
    autocmd FileType html,css EmmetInstall
    let g:user_emmet_leader_key=','
    " Goyo plugin makes text more readable when writing prose:
    map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
    " Use fzf
    nnoremap <Leader>p :Rg<CR>
    nnoremap <silent> <c-s> :Lines<CR>

    let s:nimlspexecutable = "nimlsp"
    let s:cclsexecutable = "ccls"
    let s:pylsexecutable = "pyls"

    let g:lsp_log_verbose = 0
    let g:lsp_log_file = expand('/tmp/vim-lsp.log')
    let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
    " for asyncomplete.vim log
    let g:asyncomplete_log_file = expand('/tmp/asyncomplete.log')

    let g:asyncomplete_auto_popup = 1

    if has('win32')
        let s:nimlspexecutable = "nimlsp.cmd"
        " Windows has no /tmp directory, but has $TEMP environment variable
        let g:lsp_log_file = expand('$TEMP/vim-lsp.log')
        let g:asyncomplete_log_file = expand('$TEMP/asyncomplete.log')
    endif


    " setup nimlang
    if executable(s:nimlspexecutable)
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'nimlsp',
                    \ 'cmd': {server_info->[s:nimlspexecutable]},
                    \ 'allowlist': ['nim'],
                    \ })
    endif

    " setup python
    if executable(s:pylsexecutable)
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'pyls',
                    \ 'cmd': {server_info->[s:pylsexecutable]},
                    \ 'allowlist': ['python'],
                    \ })
    endif

    " setup c/c++
    if executable(s:pylsexecutable)
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'ccls',
                    \ 'cmd': {server_info->[s:cclsexecutable]},
                    \ 'allowlist': ['c', 'cpp'],
                    \ })
    endif

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ asyncomplete#force_refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
endif
""""""" END PLUG
