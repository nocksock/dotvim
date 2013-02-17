" encoding: utf 8 
filetype off
execute pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
set nocompatible
set encoding=utf-8
" set fileencodings=utf-8,latin1

" Basic Options"{{{ "
let mapleader = ","
let maplocalleader = "\\"
let g:Powerline_symbols = 'fancy'

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set foldmethod=marker
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500 " keep 500 lines of command line history
set clipboard=unnamed
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set autoindent
set showmatch
set cursorline
set showmode
set backupdir=/tmp
set directory=/tmp " Don't clutter my dirs up with swp and tmp files
set autoread

if has('gui_running')
  set guioptions-=T
  set guifont=Ubuntu\ Mono\ for\ Powerline:h14
endif

set laststatus=2  " Always show status line.
set relativenumber
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set visualbell 
set list
set formatoptions=qrn1
set undofile
set shell=/bin/zsh

" Tabs, spaces, wrapping {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1
" }}}
" Colors and Scheme "{{{

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

if has("gui_running")
  set columns=150
  set lines=45
  set fuoptions=maxvert,maxhorz
else
  " use 16 colors outside of macvim
  " let g:solarized_termcolors=16
endif
let &t_Co=256
colors molokai

" set background=dark
" colorscheme solarized

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=black

" VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

syntax on
"}}}
"  Statusline and listchars
if has("gui")
  set listchars=tab:>⋅,eol:¬,trail:-,extends:↩,precedes:↪
  set statusline+=%<%f\%h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif
" Wildmenu "{{{
set wildmenu
set wildmode=longest,list
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
"}}}
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*" 

" Save when losing focus
au FocusLost * :wa

" save on ^s
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>i
command Q q " Bind :Q to :q
command W w " Bind :W to :w
" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
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
" Keep search matches in the middle of the window and pulse the line when moving
" to them.
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
" Window management
map <C-t> <esc>:tabnew<CR>
map <C-x> <C-w>c
" Window resizing
nnoremap <c-left> 5<c-w>>
nnoremap <c-right> 5<c-w><

map <Leader>rr :redraw!<cr>
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
" }}}
" Global abbreviations"{{{
iabbrev ldis ಠ_ಠ
iabbrev lsad ಥ_ಥ
iabbrev lhap ಥ‿ಥ
"}}}
" FileType Specifics {{{
" HTML"{{{
" fold current tag
nnoremap <leader>ft Vatzf

" }}}
" CSS "{{{
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
" Ruby {{{

augroup ft_ruby
    au!
    au BufNewfile,BufRead *.thor setlocal filetype=ruby 
augroup END

" }}}
" Javascript {{{
augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=marker

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END
" }}}
let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'
augroup ft_pde
    au BufNewFile,BufRead *.pde setlocal filetype=java
augroup END
" Markdown {{{
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
" }}}
" git stuff"{{{
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
"}}}
" Mappings for plugins and convenience {{{
let g:ctrlp_map = '<c-p>'
let g:EasyMotion_leader_key = '<Leader>m'
noremap <Leader>cc :CtrlPClearCache<CR>
map <S-TAB> :NERDTreeToggle<CR>

" Toggle "keep current line centered" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>
" Use to toggle comment current line
map <Leader>co :TComment<CR>
" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" 'in next()' textobject
vnoremap <silent> in( :<C-U>normal! f(vi(<cr>
onoremap <silent> in( :<C-U>normal! f(vi(<cr>

" Tabular 
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <Leader>a: :Tabularize /:<CR>
endif

" clean up trailing whitespaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

command Vrc :vsplit ~/.vimrc
map <Leader>vrc :Vrc<CR>

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Use Ack instead of grep
set grepprg=ack
map <leader>a<space> :Ack

" Yankring "
nnoremap <silent> <F2> :YRShow<cr>
" }}}
" Ctags stuff {{{
" Taglist
map <F3> :TagbarToggle<CR><C-W><C-T>
let Tlist_Ctags_Cmd="/usr/local/Cellar/ctags/5.8/bin/ctags"
" Set the tag file search order
set tags=./tags;
"}}}
" Shell {{{
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 
" }}}

nmap <Leader>x <Plug>ToggleAutoCloseMappings

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
