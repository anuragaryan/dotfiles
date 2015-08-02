"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" load plugins from vundle
source ~/.vim/plugins.vim

set nocompatible " not compatible with vi
set autoread " detect when a file is changed

" make backspace behave in a sane manner
set backspace=indent,eol,start


" switch syntax highlighting on
syntax on
set encoding=utf-8

autocmd! bufwritepost .vimrc source %

let mapleader=","

autocmd CompleteDone * pclose

set list listchars=tab:»·,trail:·

"I like numbers
set nu
set relativenumber

set smarttab
syn on se title
"4 space
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
"Round indent to nearest multiple of 4
set shiftround
"No line-wrapping
"set nowrap
set wrap "turn on line wrapping
set wrapmargin=8 " wrap lines when coming within n characters from side
set linebreak " set soft wrapping
set showbreak=… " show ellipsis at breaking

set autoindent " automatically set indent of new line
set smartindent


" Better copy & paste
" " When you want to paste large blocks of code into vim, press F2 before you
" " paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
set clipboard=unnamed


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


"set up the mouse
" " I know, mouse is bad, but this is useful purely for resizing splits
" visually
" " http://usevim.com/2012/05/16/mouse/
set mouse=a
set ttymouse=xterm2


" Useful settings
set history=700
set undolevels=700


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


"====[ Make the 81st column stand out ]====================
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" make paren match clearer (stolen from r00k dotfiles!)
hi MatchParen cterm=none ctermbg=black ctermfg=yellow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""To run codes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python nnoremap <buffer> <F9> :exec '!clear;python3' shellescape(@%, 1)<cr>
autocmd FileType c map <F9> :w <CR> :!gcc-4.9 -O2 -g -Wall -Wextra % -o %< && ./%< <CR>
autocmd FileType cpp map <F9> :w <CR> :!g++-4.9 -O2 -g -Wall -Wextra % -o %< && ./%< <CR>
"Check test cases, just select the case and click F6
map <F6> :call TestIt() <CR>


"HTML css
let g:html_indent_inctags="html,body,head,tbody,span,b,a,div"

""""""""markdown default"""
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Turn spellcheck on for markdown files.
autocmd BufNewFile,BufRead *.markdown,*.md set spell


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Nerdtree open in working folder
set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>

" airline
let g:airline_theme             = 'molokai'
let g:airline_powerline_fonts   = 1
let g:airline#extensions#syntastic#enabled = 1
"let g:airline_left_sep=''
"let g:airline_right_sep=''

""emmet-vim"
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"Check test cases, mapped with <F6>
""for competitive programming"
function! TestIt()
  let l:test = substitute(@+, "'", "", "g")
  let l:file = @%
  write
  let l:output = system("g++ '".file."' -g && (ulimit -c unlimited; echo '".test."' | ./a.out)")
  echo l:output
endfunction
