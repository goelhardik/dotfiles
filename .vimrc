set nu
set cursorline
set hlsearch
set laststatus=2
set statusline+=%F
set statusline+=%=
set statusline+=[%l,%c]
set formatoptions+=w
set tw=80
set colorcolumn=80
set ruler
" size of a hard tabstop
set tabstop=4
"
" size of an "indent"
set shiftwidth=4
"
" " a combination of spaces and tabs are used to simulate tab stops at a width
" " other than the (hard)tabstop
" set softtabstop=4
"
" make "tab" insert indents instead of tabs at the beginning of a line
" set smarttab
"
" " always uses spaces instead of tab characters
" set expandtab
filetype on
filetype indent plugin on
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
