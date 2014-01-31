"colorscheme mrkn256
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

"if has("cscope") && filereadable("/usr/bin/cscope")
"   set csprg=/usr/bin/cscope
"   set cst
"   set nocsverb
"   " add any database in current directory
"   if filereadable("cscope.out")
"      cs add cscope.out
"   " else add database pointed to by environment
"   elseif $CSCOPE_DB != ""
"      cs add $CSCOPE_DB
"   endif
"   set csverb
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

filetype plugin on
syntax on

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
"set expandtab		"convert tabs to spaces
set ts=4
set clipboard=unnamedplus
set number
set mouse=
set autoindent
set incsearch
set nohlsearch
set showtabline=2
set paste
"set tags = ./tags
"set tags+=/home/x0174653/git/x-loader/tags
"set tags+=/home/x0174653/git/u-boot/tags

nnoremap <t> :tabnew<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :Tagbar<CR>
nnoremap <F4> :Rgrep<CR>
nnoremap <F5> :BufExplorer<CR>
nnoremap <F6> :cope<CR>
nnoremap <F7> :cp<CR>
nnoremap <F8> :cn<CR>
nnoremap <F9> :tprevious<CR>
nnoremap <F10> :tnext<CR>
nnoremap <F11> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
  endif
endfunction

nnoremap <F12> :set invlist!<CR>

"autocompletion
"set completeopt=""
"set showmatch
map t :tabnew<CR>
map tn :tabnext<CR>
map tn :tabprevious<CR>
set ic
set tabstop=4
set expandtab
set guifont=Terminus\ 14
set t_Co=256
"set list
autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", expand('<cword>'))

" spiiph's
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file

" jamessan's
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" tpope's
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
 
 " frogonwheels'
set statusline=%f%w%m%h%1*%r%2*%{VarExists('b:devpath','<Rel>')}%3*%{VarExists('b:relpath','<Dev>')}%{XLockStat()}%=%-15(%l,%c%V%)%P

" godlygeek's
let &statusline='%<%f%{&mod?"[+]":""}%r%{&fenc !~ "^$\\|utf-8" || &bomb ? "[".&fenc.(&bomb?"-bom":"")."]" : ""}%=%15.(%l,%c%V %P%)'

" Another way to write godlygeeks:
set statusline=%<%f%m%r%{Fenc()}%=%15.(%l,%c%V\ %P%)
function! Fenc()
    if &fenc !~ "^$\|utf-8" || &bomb
        return "[" . &fenc . (&bomb ? "-bom" : "" ) . "]"
    else
         return ""
    endif
endfunction

