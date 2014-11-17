set secure nocompatible
execute pathogen#infect()
syntax enable
filetype on
filetype plugin indent on

set t_Co=8

set ruler "Always show current position
set showtabline=2
set laststatus=2 "Always display the statusline in all windows
set noshowmode "Hide the default mode text (e.g. -- INSERT -- below the statusline)
set history=10000 " Sets how many lines of history VIM has to remember
set undolevels=10000

" Turn backup off BUT save swp file in directory
set directory=~/.vim/bkps
set nobackup
set nowritebackup
"set nowb

set nostartofline
set modeline
set noendofline
"set noignorecase " No ignore case when searching
set ignorecase " Ignore case when searching
set smartcase " Override the 'ignorecase' option if the search pattern contains upper case characters.
set hlsearch " Highlight search results
set showfulltag
set showmatch " Show matching brackets when text indicator is over them
set showcmd

set ch=1 bs=2
set incsearch report=0 title

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab  " Use the appropriate number of spaces to insert a <Tab>.
               " Spaces are used in indents with the '>' and '<' commands
               " and when 'autoindent' is on. To insert a real tab when
               " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab " Be smart when using tabs ;)
set autoindent " Copy indent from current line when starting a new line
               " (typing <CR> in Insert mode or when using the "o" or "O"
			   " command).

set nomousefocus mousehide
set lazyredraw " Don't redraw while executing macros (good performance config)

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language

set wildmenu " Turn on the WiLd menu
set wcm=<TAB>
set pastetoggle=<F12> " Toggle paste mode on and off

set background=dark
hi comment		ctermfg=darkgreen
hi NonText		ctermfg=blue
hi search		ctermfg=black	ctermbg=yellow
"hi StatusLine	ctermfg=blue	ctermbg=white
"hi StatusLineNC	ctermfg=black	ctermbg=white

" map keys for tab
map <C-w> :tabprevious<cr>
nmap <C-w> :tabprevious<cr>
imap <C-w> <ESC>:tabprevious<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>

map <silent> <F4> :%s/\s\+$//g<CR>
map <silent> <F9> :runtime! syntax/html.vim<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Set +x to file if first line contain #! and /bin/
function ModeChange()
	if getline(1) =~ "^#!"
		if getline(1) =~ "/bin/"
			silent !chmod a+x <afile>
		endif
	endif
endfunction
au BufWritePost * call ModeChange()

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

if has("viminfo")
	if filewritable(expand("$HOME/.vim/viminfo")) == 1 ||
			\ filewritable(expand("$HOME/.vim/")) == 2
		set viminfo=!,%,'5000,\"10000,:10000,/10000,n~/.vim/viminfo
	else
		set viminfo=
	endif
endif

"AirLine Plugin Settings
let g:airline_theme='dark'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '¶ '
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'


" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
	let my_auto_commands_loaded = 1
	" Large files are > 10M
	" Set options:
	" eventignore+=FileType (no syntax highlighting etc
	" assumes FileType always on)
	" noswapfile (save copy of file)
	" bufhidden=unload (save memory when other file is viewed)
	" buftype=nowritefile (is read-only)
	" undolevels=-1 (no undo possible)
	let g:LargeFile = 1024 * 1024 * 10
	augroup LargeFile
		autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
	augroup END
endif
