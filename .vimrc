" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: 
" A minimal, but feature rich, example .vimrc. If you are a
" newbie, basing your first .vimrc on this file is a good choice.
" If you're a more advanced user, building your own .vimrc based
" on this file is still a good idea.

" Currently works (tabulate lines)
map <Tab> >
imap <Tab> <Esc> >
vmap <Tab> >gv
map <S-Tab> <
imap <S-Tab> <Esc> <
vmap <S-Tab> <gv

" Experimental
" Indents word-wrapped lines as much as the 'parent' line
set breakindent
" Ensures word-wrap does not split words
set formatoptions=l
set lbr




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
"if &compatible
"	set nocompatible
"endif

" Godot Script Highlighting
"call plug#begin('.vim/plugged')
"Plug '~/.vim/plugged/vim-gdscript3'
"call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Genera
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype on
filetype indent on

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
"filetype indent plugin on

" Set to auto read when a file is changed from the outside
set autoread

" set tab size to be of 4 (spaces)
set tabstop=4

" Auto correct (I'm really bad at typing)
set spelllang=en

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast quiting (not working yet)
" nmap <leader>q :q!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

command P execute "w | !clear; python %"

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac


set noswapfile
set nobackup
set nowritebackup
set noundofile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

 " Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase


" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" Show line number
set number 
" set number relativenumber

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
"set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
"set shiftwidth=4
"set softtabstop=4
"set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
set shiftwidth=3
set tabstop=3

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax on

" Prefered colours
colorscheme pablo

" Text wrapping
set wrap linebreak "nolist

" share the clipboard with other terminals
" set clipboard^=unnamed

" set the line color to green
highlight LineNr ctermfg=brown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line (stolen)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

"hi StatusLine ctermbg=0 cterm=NONE




"""""""""""""""""""""""""""""""""
" REMOVED
""""""""""""""""""""""""""""""""""

" Always display the status line, even if only one window is displayed
" set laststatus=2


" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
" map Y y$
 

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>

" Use <F11> to toggle between 'paste' and 'nopaste'
" set pastetoggle=<F11>
