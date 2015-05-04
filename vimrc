" encoding: utf 8
"
" Welcome to my crib.
"
" Author: Nils Riedemann

" Vundle Stuff {{{
" needed for init

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'Raimondi/delimitMate.git'
Plugin 'nosami/Omnisharp'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'SirVer/ultisnips.git'
Plugin 'bling/vim-airline.git'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim.git'
Plugin 'pangloss/vim-javascript.git'
Plugin 'sjl/gundo.vim.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'shougo/neocomplete.vim.git'
Plugin 'godlygeek/tabular.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-dispatch.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-vinegar.git'

call vundle#end()
filetype plugin indent on

set nocompatible
"}}}
"
set t_Co=256 " term colors
set encoding=utf-8

" Airline config {{{
let g:airline_powerline_fonts = 0
let g:airline_theme='powerlineish'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#branch#enabled = 1
" }}}

" Basic Options"{{{ "
let mapleader = "\<space>"
let maplocalleader = "\\"

set number
set relativenumber
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set foldmethod=marker
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500 " keep 500 lines of command line history
set clipboard=unnamed
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set autoindent
set breakindent
set showmatch
set cursorline
set showmode
set list
set backupdir=/tmp
set directory=/tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set synmaxcol=160
set guioptions-=T
set laststatus=2  " Always show status line.
set gdefault
set autoindent
set visualbell
set formatoptions=qrn1
set undofile
set shell=/bin/zsh
let g:user_zen_leader_key = '<c-y>'
set t_ut=

" Tabs, spaces, wrapping {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab
set nowrap
set textwidth=80
set formatoptions=qrn1
" }}}
" Colors and Scheme "{{{

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
colors molokai

highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 100)

if has("gui_running")
  set columns=150
  set lines=45
  set fuoptions=maxvert,maxhorz
endif

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=black

" VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

syntax on
"}}}
"  Listchars
set listchars=tab:\|⋅,eol:¬,trail:-,extends:↩,precedes:↪

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" Wildmenu "{{{
set wildmode=longest,list,full
set wildmenu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
"}}}

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Save when losing focus
augroup global_autocommands
	autocmd!
	au FocusLost * :wa
	" Resize splits when the window is resized
	au VimResized * exe "normal! \<c-w>="
augroup END
"}}}
" Search Options"{{{
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
"}}}
" Movement "{{{
" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_

" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Faster Esc
inoremap jk <ESC>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" }}}
" Window Management "{{{

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l
map <C-t> <esc>:tabnew<CR>

"}}}
" Modeline Magic"{{{
" Taken from: http://vim.wikia.com/wiki/Modeline_magic
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d cc=80 ft=%s:",
        \ &tabstop, &shiftwidth, &textwidth, &ft)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
"}}}
" Backups {{{
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}
" Folding {{{

set foldlevelstart=0

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap <c-z> mzzMzvzz`zzz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 2
    return line . ' ' . repeat("⋅",fillcharcount) . ' ' . foldedlinecount . ' ⬍  '
endfunction " }}}
" set foldtext=MyFoldText()

" }}}
" FileType Specifics {{{
" .HTML"{{{
" fold current tag
augroup ft_html
	au!
	au FileType html setlocal foldmethod=manual
augroup END
" }}}
augroup ft_hbs
	au!
	au BufNewFile,BufRead *.hbs setlocal filetype=handlebars.html
augroup END
" .CSS "{{{
augroup ft_css
  au!
  au BufNewFile,BufRead *.less setlocal filetype=less
  au BufNewFile,BufREad *.scss setlocal filetype=sass

  au Filetype sass,less,css setlocal foldmethod=marker
  au Filetype sass,less,css setlocal foldmarker={,}
  au Filetype sass,less,css setlocal omnifunc=csscomplete#CompleteCSS
  au Filetype sass,less,css setlocal iskeyword+=-

  au BufNewFile,BufRead *.scss,*.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
augroup END
" }}}
" .RB Ruby {{{

augroup ft_ruby
    au!
    au BufNewfile,BufRead *.thor,Guardfile setlocal filetype=ruby
    au Filetype ruby set et
augroup END

" }}}
" .JS JavaScript {{{
augroup ft_javascript
	au!
	au BufNewFile,BufRead .jshintrc setlocal filetype=javascript
	au BufNewFile,BufRead Gruntfile setlocal filetype=javascript

	au FileType javascript setlocal foldmethod=marker
	au FileType javascript setlocal foldmarker={,}


	" when typing a parenthesis followed by <cr>, indent correctly without folding
	au Filetype javascript inoremap <buffer> "{<cr>" {}<left><cr><tab>.<cr><esc>kA<bs>
	au Filetype javascript inoremap <buffer> "(<cr>" ()<left><cr><tab>.<cr><esc>kA<bs>
	au Filetype javascript inoremap <buffer> "[<cr>" []<left><cr><tab>.<cr><esc>kA<bs>

	" only show invisble characters in normal mode. just trying to see if i like
	" that
	au FileType javascript :au InsertLeave *.js setlocal nolist
	au FileType javascript :au InsertEnter *.js setlocal list
augroup END
" }}}
" .PDE Processing {{{
augroup ft_pde
	au BufNewFile,BufRead *.pde setlocal filetype=java
	au Filetype java nnoremap <Leader>bb :!processing-java --run --sketch=$(pwd) --output=$(pwd)/tmp --force<CR>
	au Filetype java nnoremap <Leader>bf :!processing-java --present --sketch=$(pwd) --output=$(pwd)/tmp --force<CR>
augroup END
"}}}
" .MD Markdown {{{
augroup ft_markdown
	au!
	au BufNewFile,BufRead *.m*down setlocal filetype=markdown
	au BufNewFile,BufRead *.md setlocal filetype=markdown

	" Use <localleader>1/2/3 to add headings.
	au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
	au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
	au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
augroup END
" }}}
" HELP {{{
augroup ft_help
	au!
	au FileType help nnoremap q :close<cr>
augroup END
" }}}
" }}}
" Mappings for plugins and convenience {{{

" make text uppercase
inoremap <c-u> <esc>zviwUea

" make current line a comment
imap <c-c> <esc>mzgcc`z

" zoom to head level
nnoremap zh mzzt10<c-u>`z

" omnisharp {{{
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuildAsync<cr>
autocmd BufWritePost *.cs call OmniSharp#AddToProject()
autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
set completeopt-=preview
let g:OmniSharp_typeLookupInPreview = 0
" }}}

" neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist'
        \ }

if !exists('g:neocomplete#sources')
        let g:neocomplete#sources = {}
endif

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
let g:neocomplete#sources.cs = ['omni']
let g:neocomplete#enable_refresh_always = 0
let g:echodoc_enable_at_startup = 1
let g:neocomplete#enable_insert_char_pre = 1
" }}}

" syntastic {{{
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list = 1
"}}}

" map <F4> :NERDTreeToggle<CR>

let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'
let g:UltiSnipsEditSplit = 'vertical'

" Toggle "keep current line centered" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" 'in next()' textobject
vnoremap <silent> in( :<C-U>normal! f(vi(<cr>
onoremap <silent> in( :<C-U>normal! f(vi(<cr>

" Tabular
if exists(":Tabularize")
  nnoremap <Leader>a= :Tabularize /=<CR>
  vnoremap <Leader>a= :Tabularize /=<CR>
  nnoremap <Leader>a: :Tabularize /:<CR>
  vnoremap <Leader>a: :Tabularize /:<CR>
endif

" git issue stuff
nnoremap <Leader>gg :Gstatus<cr>
nnoremap <Leader>gp :Dispatch! git push<cr>
nnoremap <Leader>gi :Dispatch gh issue
nnoremap <Leader>gii :Dispatch gh issue<cr>
nnoremap <Leader>gin :Dispatch gh issue -lA noxoc<cr>

" clean up trailing whitespaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo "sourced .vimrc"<cr>

" Gundo
nnoremap <F5> :GundoToggle<CR>

" }}}
" Ctags stuff {{{
" Taglist
" let g:tagbar_type_javascript = {
"     \ 'ctagsbin' : '/usr/local/bin/jsctags'
" \ }
" map <F3> :TagbarToggle<CR>
" " Set the tag file search order
" set tags=./tags;
"}}}
" Pulse Line {{{
function! s:Pulse() " {{{
    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 1m
    endfor
    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 1m
    endfor

    execute 'hi ' . old_hi
endfunction " }}}

command! -nargs=0 Pulse call s:Pulse()
"}}}

command! W :wa
command! Fth :set ft=html
command! Ftp :set ft=php
" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" echom \"ʕ •ᴥ•ʔ GROARRR\"
