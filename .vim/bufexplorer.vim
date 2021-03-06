" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=1

    " add any cscope database in current directory
    "if filereadable("cscope.out")
    "    cs add cscope.out  
   " else add the database pointed to by environment variable 
    "elseif $CSCOPE_DB != ""
    "    cs add $CSCOPE_DB
    "endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    set timeoutlen=3000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif


                                                                                                                                                                                                                                                                                                                                                     .vim/plugin/fonts.vim.old                                                                           0000644 0001751 0001751 00000010753 12171173654 014531  0                                                                                                    ustar   x0199365                        x0199365                                                                                                                                                                                                               "-------------------------------------------------------------------------------
"  Description: Quick Font changer 
"   Maintainer:	Martin Krischik
"    Copyright: Copyright (C) 2006 Martin Krischik
" Name Of File: plugin/fonts.vim
" Last Changed: Monday, 09 May 2006
"      Version: 1.4
"      History: 01.11.2006 MK Sun Solaris Support 
"	   URL: http://www.vim.org/account/profile.php?user=7818
"	 Usage: copy to plugin directory
"-------------------------------------------------------------------------------

if exists("g:loaded_fonts") || 
    \ ! has ("gui_running")
    finish
else
    let g:loaded_fonts=1

    if has ("vms") || has ("gui_motif")
	let g:Font_L1="-misc-fixed-medium-r-normal-*-14-*-*-*-c-*-iso8859-1"
	let g:Font_L2="-misc-fixed-medium-r-normal-*-18-*-*-*-c-*-iso8859-1"
	let g:Font_L3="-misc-fixed-medium-r-normal-*-20-*-*-*-c-*-iso8859-1"
	let g:Font_U1="-misc-fixed-medium-r-normal-*-14-*-*-*-c-*-iso10646-1"
	let g:Font_U2="-misc-fixed-medium-r-normal-*-18-*-*-*-c-*-iso10646-1"
	let g:Font_U3="-misc-fixed-medium-r-normal-*-20-*-*-*-c-*-iso10646-1"
	let g:Font_S1="132 60"
	let g:Font_S2="96 45"
	let g:Font_S3="96 42"
    elseif has ("gui_win32")
	let g:Font_L1="Bitstream_Vera_Sans_Mono:h9:cANSI"
	let g:Font_L2="Bitstream_Vera_Sans_Mono:h11:cANSI"
	let g:Font_L3="Bitstream_Vera_Sans_Mono:h13:cANSI"
	let g:Font_U1="Bitstream_Vera_Sans_Mono:h9:cDEFAULT"
	let g:Font_U2="Bitstream_Vera_Sans_Mono:h11:cDEFAULT"
	let g:Font_U3="Bitstream_Vera_Sans_Mono:h13:cDEFAULT"
	let g:Font_S1="132 60"
	let g:Font_S2="96 45"
	let g:Font_S3="96 42"
    elseif has ("gui_gtk")
	let g:Font_L1="Bitstream Vera Sans Mono 9"
	let g:Font_L2="Bitstream Vera Sans Mono 11"    
	let g:Font_L3="Bitstream Vera Sans Mono 13"
	let g:Font_U1=g:Font_L1
	let g:Font_U2=g:Font_L2
	let g:Font_U3=g:Font_L3
	let g:Font_S1="132 48"
	let g:Font_S2="96 42"
	let g:Font_S3="96 38"
    elseif has ("gui_kde")
	let g:Font_L1="Bitstream Vera Sans Mono/9/-1/5/50/0/0/0/1/0"
	let g:Font_L2="Bitstream Vera Sans Mono/11/-1/5/50/0/0/0/1/0"
	let g:Font_L3="Bitstream Vera Sans Mono/13/-1/5/50/0/0/0/1/0"
	let g:Font_U1=g:Font_L1
	let g:Font_U2=g:Font_L2   
	let g:Font_U3=g:Font_L3
	let g:Font_S1="132 49"
	let g:Font_S2="96 40"
	let g:Font_S3="96 35"
    else
	let g:Font_L1="-bitstream-bitstream vera sans mono-medium-r-normal-*-14-*-100-100-m-*-iso8859-1"
	let g:Font_L2="-bitstream-bitstream vera sans mono-medium-r-normal-*-16-*-100-100-m-*-iso8859-1"
	let g:Font_L3="-bitstream-bitstream vera sans mono-medium-r-normal-*-18-*-100-100-m-*-iso8859-1"
	let g:Font_U1="-bitstream-bitstream vera sans mono-medium-r-normal-*-14-*-100-100-m-*-iso10646-1"
	let g:Font_U2="-bitstream-bitstream vera sans mono-medium-r-normal-*-16-*-100-100-m-*-iso10646-1"
	let g:Font_U3="-bitstream-bitstream vera sans mono-medium-r-normal-*-18-*-100-100-m-*-iso10646-1"
	let g:Font_S1="132 60"
	let g:Font_S2="96 45"
	let g:Font_S3="96 42"
    endif

    function s:Set_Font (Size)
	if a:Size != 0
	    let g:Font_Size=a:Size
	end
	if &encoding == "utf-8"
	    let &guifont=g:Font_U{g:Font_Size}	      
	else
	    let &guifont=g:Font_L{g:Font_Size}
	endif	     
	if a:Size != 0
	    execute "winsize" g:Font_S{g:Font_Size}
	end
    endfunction Set_Font

    autocmd EncodingChanged * :call s:Set_Font (0)

    if &diff
	autocmd GUIEnter * :call s:Set_Font (1)
    else
	autocmd GUIEnter * :call s:Set_Font (2)
    endif

    execute "nnoremap <unique> " . escape(g:mapleader . "1" , '\') .	  " :call <SID>Set_Font (1) <CR>"
    execute "nnoremap <unique> " . escape(g:mapleader . "2" , '\') .	  " :call <SID>Set_Font (2) <CR>"
    execute "nnoremap <unique> " . escape(g:mapleader . "3" , '\') .	  " :call <SID>Set_Font (3) <CR>"
    execute "inoremap <unique> " . escape(g:mapleader . "1" , '\') . " <C-O>:call <SID>Set_Font (1) <CR>"
    execute "inoremap <unique> " . escape(g:mapleader . "2" , '\') . " <C-O>:call <SID>Set_Font (2) <CR>"
    execute "inoremap <unique> " . escape(g:mapleader . "3" , '\') . " <C-O>:call <SID>Set_Font (3) <CR>"

    execute "48amenu Plugin.Font.Small<Tab>"  . escape(g:mapleader . "1" , '\') . " :call <SID>Set_Font (1)<CR>"
    execute "48amenu Plugin.Font.Medium<Tab>" . escape(g:mapleader . "2" , '\') . " :call <SID>Set_Font (2)<CR>"
    execute "48amenu Plugin.Font.Large<Tab>"  . escape(g:mapleader . "3" , '\') . " :call <SID>Set_Font (3)<CR>"

    finish
endif

"-------------------------------------------------------------------------------
" vim: textwidth=0 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
                     .vim/plugin/fugitive.vim                                                                            0000644 0001751 0001751 00000225021 12126773534 014444  0                                                                                                    ustar   x0199365                        x0199365                                                                                                                                                                                                               " fugitive.vim - A Git wrapper so awesome, it should be illegal
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2
" GetLatestVimScripts: 2975 1 :AutoInstall: fugitive.vim

if exists('g:loaded_fugitive') || &cp
  finish
endif
let g:loaded_fugitive = 1

if !exists('g:fugitive_git_executable')
  let g:fugitive_git_executable = 'git'
endif

" Utility {{{1

function! s:function(name) abort
  return function(substitute(a:name,'^s:',matchstr(expand('<sfile>'), '<SNR>\d\+_'),''))
endfunction

function! s:sub(str,pat,rep) abort
  return substitute(a:str,'\v\C'.a:pat,a:rep,'')
endfunction

function! s:gsub(str,pat,rep) abort
  return substitute(a:str,'\v\C'.a:pat,a:rep,'g')
endfunction

function! s:shellesc(arg) abort
  if a:arg =~ '^[A-Za-z0-9_/.-]\+$'
    return a:arg
  elseif &shell =~# 'cmd' && a:arg !~# '"'
    return '"'.a:arg.'"'
  else
    return shellescape(a:arg)
  endif
endfunction

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

function! s:throw(string) abort
  let v:errmsg = 'fugitive: '.a:string
  throw v:errmsg
endfunction

function! s:warn(str)
  echohl WarningMsg
  echomsg a:str
  echohl None
  let v:warningmsg = a:str
endfunction

function! s:shellslash(path)
  if exists('+shellslash') && !&shellslash
    return s:gsub(a:path,'\\','/')
  else
    return a:path
  endif
endfunction

function! s:recall()
  let rev = s:buffer().rev()
  if rev ==# ':'
    return matchstr(getline('.'),'^#\t\%([[:alpha:] ]\+: *\)\=\zs.\{-\}\ze\%( (new commits)\)\=$\|^\d\{6} \x\{40\} \d\t\zs.*')
  endif
  return rev
endfunction

function! s:add_methods(namespace, method_names) abort
  for name in a:method_names
    let s:{a:namespace}_prototype[name] = s:function('s:'.a:namespace.'_'.name)
  endfor
endfunction

let s:commands = []
function! s:command(definition) abort
  let s:commands += [a:definition]
endfunction

function! s:define_commands()
  for command in s:commands
    exe 'command! -buffer '.command
  endfor
endfunction

function! s:compatibility_check()
  if exists('b:git_dir') && exists('*GitBranchInfoCheckGitDir') && !exists('g:fugitive_did_compatibility_warning')
    let g:fugitive_did_compatibility_warning = 1
    call s:warn("See http://github.com/tpope/vim-fugitive/issues#issue/1 for why you should remove git-branch-info.vim")
  endif
endfunction

augroup fugitive_utility
  autocmd!
  autocmd User Fugitive call s:define_commands()
  autocmd VimEnter * call s:compatibility_check()
augroup END

let s:abstract_prototype = {}

" }}}1
" Initialization {{{1

function! s:ExtractGitDir(path) abort
  let path = s:shellslash(a:path)
  if path =~? '^fugitive://.*//'
    return matchstr(path,'fugitive://\zs.\{-\}\ze//')
  endif
  let fn = fnamemodify(path,':s?[\/]$??')
  let ofn = ""
  let nfn = fn
  while fn != ofn
    if isdirectory(fn) && filereadable(fn . '/.git/HEAD')
      return s:sub(simplify(fnamemodify(fn . '/.git',':p')),'\W$','')
    elseif fn =~ '\.git$' && filereadable(fn . '/HEAD')
      return s:sub(simplify(fnamemodify(fn,':p')),'\W$','')
    endif
    let ofn = fn
    let fn = fnamemodify(ofn,':h')
  endwhile
  return ''
endfunction

function! s:Detect(path)
  if exists('b:git_dir') && (b:git_dir ==# '' || b:git_dir =~# '/$')
    unlet b:git_dir
  endif
  if !exists('b:git_dir')
    let dir = s:ExtractGitDir(a:path)
    if dir != ''
      let b:git_dir = dir
    endif
  endif
  if exists('b:git_dir')
    silent doautocmd User Fugitive
    cnoremap <expr> <buffer> <C-R><C-G> <SID>recall()
    let buffer = fugitive#buffer()
    if expand('%:p') =~# '//'
      call buffer.setvar('&path',s:sub(buffer.getvar('&path'),'^\.%(,|$)',''))
    endif
    if stridx(buffer.getvar('&tags'),escape(b:git_dir.'/tags',', ')) == -1
      call buffer.setvar('&tags',escape(b:git_dir.'/tags',', ').','.buffer.getvar('&tags'))
      if &filetype != ''
        call buffer.setvar('&tags',escape(b:git_dir.'/'.&filetype.'.tags',', ').','.buffer.getvar('&tags'))
      endif
    endif
  endif
endfunction

augroup fugitive
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:Detect(expand('<amatch>:p'))
  autocmd FileType           netrw call s:Detect(expand('<afile>:p'))
  autocmd VimEnter * if expand('<amatch>')==''|call s:Detect(getcwd())|endif
  autocmd BufWinLeave * execute getwinvar(+bufwinnr(+expand('<abuf>')), 'fugitive_leave')
augroup END

" }}}1
" Repository {{{1

let s:repo_prototype = {}
let s:repos = {}

function! s:repo(...) abort
  let dir = a:0 ? a:1 : (exists('b:git_dir') && b:git_dir !=# '' ? b:git_dir : s:ExtractGitDir(expand('%:p')))
  if dir !=# ''
    if has_key(s:repos,dir)
      let repo = get(s:repos,dir)
    else
      let repo = {'git_dir': dir}
      let s:repos[dir] = repo
    endif
    return extend(extend(repo,s:repo_prototype,'keep'),s:abstract_prototype,'keep')
  endif
  call s:throw('not a git repository: '.expand('%:p'))
endfunction

function! fugitive#repo(...)
  return call('s:repo', a:000)
endfunction

function! s:repo_dir(...) dict abort
  return join([self.git_dir]+a:000,'/')
endfunction

function! s:repo_tree(...) dict abort
  if !self.bare()
    let dir = fnamemodify(self.git_dir,':h')
    return join([dir]+a:000,'/')
  endif
  call s:throw('no work tree')
endfunction

function! s:repo_bare() dict abort
  return self.dir() !~# '/\.git$'
endfunction

function! s:repo_translate(spec) dict abort
  if a:spec ==# '.' || a:spec ==# '/.'
    return self.bare() ? self.dir() : self.tree()
  elseif a:spec =~# '^/'
    return fnamemodify(self.dir(),':h').a:spec
  elseif a:spec =~# '^:[0-3]:'
    return 'fugitive://'.self.dir().'//'.a:spec[1].'/'.a:spec[3:-1]
  elseif a:spec ==# ':'
    if $GIT_INDEX_FILE =~# '/[^/]*index[^/]*\.lock$' && fnamemodify($GIT_INDEX_FILE,':p')[0:strlen(s:repo().dir())] ==# s:repo().dir('') && filereadable($GIT_INDEX_FILE)
      return fnamemodify($GIT_INDEX_FILE,':p')
    else
      return self.dir('index')
    endif
  elseif a:spec =~# '^:/'
    let ref = self.rev_parse(matchstr(a:spec,'.[^:]*'))
    return 'fugitive://'.self.dir().'//'.ref
  elseif a:spec =~# '^:'
    return 'fugitive://'.self.dir().'//0/'.a:spec[1:-1]
  elseif a:spec =~# 'HEAD\|^refs/' && a:spec !~ ':' && filereadable(self.dir(a:spec))
    return self.dir(a:spec)
  elseif filereadable(s:repo().dir('refs/'.a:spec))
    return self.dir('refs/'.a:spec)
  elseif filereadable(s:repo().dir('refs/tags/'.a:spec))
    return self.dir('refs/tags/'.a:spec)
  elseif filereadable(s:repo().dir('refs/heads/'.a:spec))
    return self.dir('refs/heads/'.a:spec)
  elseif filereadable(s:repo().dir('refs/remotes/'.a:spec))
    return self.dir('refs/remotes/'.a:spec)
  elseif filereadable(s:repo().dir('refs/remotes/'.a:spec.'/HEAD'))
    return self.dir('refs/remotes/'.a:spec,'/HEAD')
  else
    try
      let ref = self.rev_parse(matchstr(a:spec,'[^:]*'))
      let path = s:sub(matchstr(a:spec,':.*'),'^:','/')
      return 'fugitive://'.self.dir().'//'.ref.path
    catch /^fugitive:/
      return self.tree(a:spec)
    endtry
  endif
endfunction

call s:add_methods('repo',['dir','tree','bare','translate'])

function! s:repo_git_command(...) dict abort
  let git = g:fugitive_git_executable . ' --git-dir='.s:shellesc(self.git_dir)
  return git.join(map(copy(a:000),'" ".s:shellesc(v:val)'),'')
endfunction

function! s:repo_git_chomp(...) dict abort
  return s:sub(system(call(self.git_command,a:000,self)),'\n$','')
endfunction

function! s:repo_git_chomp_in_tree(...) dict abort
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
  let dir = getcwd()
  try
    execute cd.'`=s:repo().tree()`'
    return call(s:repo().git_chomp, a:000, s:repo())
  finally
    execute cd.'`=dir`'
  endtry
endfunction

function! s:repo_rev_parse(rev) dict abort
  let hash = self.git_chomp('rev-parse','--verify',a:rev)
  if hash =~ '\<\x\{40\}$'
    return matchstr(hash,'\<\x\{40\}$')
  endif
  call s:throw('rev-parse '.a:rev.': '.hash)
endfunction

call s:add_methods('repo',['git_command','git_chomp','git_chomp_in_tree','rev_parse'])

function! s:repo_dirglob(base) dict abort
  let base = s:sub(a:base,'^/','')
  let matches = split(glob(self.tree(s:gsub(base,'/','*&').'*/')),"\n")
  call map(matches,'v:val[ strlen(self.tree())+(a:base !~ "^/") : -1 ]')
  return matches
endfunction

function! s:repo_superglob(base) dict abort
  if a:base =~# '^/' || a:base !~# ':'
    let results = []
    if a:base !~# '^/'
      let heads = ["HEAD","ORIG_HEAD","FETCH_HEAD","MERGE_HEAD"]
      let heads += sort(split(s:repo().git_chomp("rev-parse","--symbolic","--branches","--tags","--remotes"),"\n"))
      call filter(heads,'v:val[ 0 : strlen(a:base)-1 ] ==# a:base')
      let results += heads
    endif
    if !self.bare()
      let base = s:sub(a:base,'^/','')
      let matches = split(glob(self.tree(s:gsub(base,'/','*&').'*')),"\n")
      call map(matches,'s:shellslash(v:val)')
      call map(matches,'v:val !~ "/$" && isdirectory(v:val) ? v:val."/" : v:val')
      call map(matches,'v:val[ strlen(self.tree())+(a:base !~ "^/") : -1 ]')
      let results += matches
    endif
    return results

  elseif a:base =~# '^:'
    let entries = split(self.git_chomp('ls-files','--stage'),"\n")
    call map(entries,'s:sub(v:val,".*(\\d)\\t(.*)",":\\1:\\2")')
    if a:base !~# '^:[0-3]\%(:\|$\)'
      call filter(entries,'v:val[1] == "0"')
      call map(entries,'v:val[2:-1]')
    endif
    call filter(entries,'v:val[ 0 : strlen(a:base)-1 ] ==# a:base')
    return entries

  else
    let tree = matchstr(a:base,'.*[:/]')
    let entries = split(self.git_chomp('ls-tree',tree),"\n")
    call map(entries,'s:sub(v:val,"^04.*\\zs$","/")')
    call map(entries,'tree.s:sub(v:val,".*\t","")')
    return filter(entries,'v:val[ 0 : strlen(a:base)-1 ] ==# a:base')
  endif
endfunction

call s:add_methods('repo',['dirglob','superglob'])

function! s:repo_config(conf) dict abort
  return matchstr(system(s:repo().git_command('config').' '.a:conf),"[^\r\n]*")
endfun

function! s:repo_user() dict abort
  let username = s:repo().config('user.name')
  let useremail = s:repo().config('user.email')
  return username.' <'.useremail.'>'
endfun

function! s:repo_aliases() dict abort
  if !has_key(self,'_aliases')
    let self._aliases = {}
    for line in split(self.git_chomp('config','--get-regexp','^alias[.]'),"\n")
      let self._aliases[matchstr(line,'\.\zs\S\+')] = matchstr(line,' \zs.*')
    endfor
  endif
  return self._aliases
endfunction

call s:add_methods('repo',['config', 'user', 'aliases'])

function! s:repo_keywordprg() dict abort
  let args = ' --git-dir='.escape(self.dir(),"\\\"' ").' show'
  if has('gui_running') && !has('win32')
    return g:fugitive_git_executable . ' --no-pager' . args
  else
    return g:fugitive_git_executable . args
  endif
endfunction

call s:add_methods('repo',['keywordprg'])

" }}}1
" Buffer {{{1

let s:buffer_prototype = {}

function! s:buffer(...) abort
  let buffer = {'#': bufnr(a:0 ? a:1 : '%')}
  call extend(extend(buffer,s:buffer_prototype,'keep'),s:abstract_prototype,'keep')
  if buffer.getvar('git_dir') !=# ''
    return buffer
  endif
  call s:throw('not a git repository: '.expand('%:p'))
endfunction

function! fugitive#buffer(...) abort
  return s:buffer(a:0 ? a:1 : '%')
endfunction

function! s:buffer_getvar(var) dict abort
  return getbufvar(self['#'],a:var)
endfunction

function! s:buffer_setvar(var,value) dict abort
  return setbufvar(self['#'],a:var,a:value)
endfunction

function! s:buffer_getline(lnum) dict abort
  return getbufline(self['#'],a:lnum)[0]
endfunction

function! s:buffer_repo() dict abort
  return s:repo(self.getvar('git_dir'))
endfunction

function! s:buffer_type(...) dict abort
  if self.getvar('fugitive_type') != ''
    let type = self.getvar('fugitive_type')
  elseif fnamemodify(self.spec(),':p') =~# '.\git/refs/\|\.git/\w*HEAD$'
    let type = 'head'
  elseif self.getline(1) =~ '^tree \x\{40\}$' && self.getline(2) == ''
    let type = 'tree'
  elseif self.getline(1) =~ '^\d\{6\} \w\{4\} \x\{40\}\>\t'
    let type = 'tree'
  elseif self.getline(1) =~ '^\d\{6\} \x\{40\}\> \d\t'
    let type = 'index'
  elseif isdirectory(self.spec())
    let type = 'directory'
  elseif self.spec() == ''
    let type = 'null'
  else
    let type = 'file'
  endif
  if a:0
    return !empty(filter(copy(a:000),'v:val ==# type'))
  else
    return type
  endif
endfunction

if has('win32')

  function! s:buffer_spec() dict abort
    let bufname = bufname(self['#'])
    let retval = ''
    for i in split(bufname,'[^:]\zs\\')
      let retval = fnamemodify((retval==''?'':retval.'\').i,':.')
    endfor
    return s:shellslash(fnamemodify(retval,':p'))
  endfunction

else

  function! s:buffer_spec() dict abort
    let bufname = bufname(self['#'])
    return s:shellslash(bufname == '' ? '' : fnamemodify(bufname,':p'))
  endfunction

endif

function! s:buffer_name() dict abort
  return self.spec()
endfunction

function! s:buffer_commit() dict abort
  return matchstr(self.spec(),'^fugitive://.\{-\}//\zs\w*')
endfunction

function! s:buffer_path(...) dict abort
  let rev = matchstr(self.spec(),'^fugitive://.\{-\}//\zs.*')
  if rev != ''
    let rev = s:sub(rev,'\w*','')
  elseif self.repo().bare()
    let rev = '/.git'.self.spec()[strlen(self.repo().dir()) : -1]
  else
    let rev = self.spec()[strlen(self.repo().tree()) : -1]
  endif
  return s:sub(s:sub(rev,'.\zs/$',''),'^/',a:0 ? a:1 : '')
endfunction

function! s:buffer_rev() dict abort
  let rev = matchstr(self.spec(),'^fugitive://.\{-\}//\zs.*')
  if rev =~ '^\x/'
    return ':'.rev[0].':'.rev[2:-1]
  elseif rev =~ '.'
    return s:sub(rev,'/',':')
  elseif self.spec() =~ '\.git/index$'
    return ':'
  elseif self.spec() =~ '\.git/refs/\|\.git/.*HEAD$'
    return self.spec()[strlen(self.repo().dir())+1 : -1]
  else
    return self.path()
  endif
endfunction

function! s:buffer_sha1() dict abort
  if self.spec() =~ '^fugitive://' || self.spec() =~ '\.git/refs/\|\.git/.*HEAD$'
    return self.repo().rev_parse(self.rev())
  else
    return ''
  endif
endfunction

function! s:buffer_expand(rev) dict abort
  if a:rev =~# '^:[0-3]$'
    let file = a:rev.self.path(':')
  elseif a:rev =~# '^[-:]/$'
    let file = '/'.self.path()
  elseif a:rev =~# '^-'
    let file = 'HEAD^{}'.a:rev[1:-1].self.path(':')
  elseif a:rev =~# '^@{'
    let file = 'HEAD'.a:rev.self.path(':')
  elseif a:rev =~# '^[~^]'
    let commit = s:sub(self.commit(),'^\d=$','HEAD')
    let file = commit.a:rev.self.path(':')
  else
    let file = a:rev
  endif
  return s:sub(s:sub(file,'\%$',self.path()),'\.\@<=/$','')
endfunction

function! s:buffer_containing_commit() dict abort
  if self.commit() =~# '^\d$'
    return ':'
  elseif self.commit() =~# '.'
    return self.commit()
  else
    return 'HEAD'
  endif
endfunction

call s:add_methods('buffer',['getvar','setvar','getline','repo','type','spec','name','commit','path','rev','sha1','expand','containing_commit'])

" }}}1
" Git {{{1

call s:command("-bang -nargs=? -complete=customlist,s:GitComplete Git :execute s:Git(<bang>0,<q-args>)")

function! s:ExecuteInTree(cmd) abort
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
  let dir = getcwd()
  try
    execute cd.'`=s:repo().tree()`'
    execute a:cmd
  finally
    execute cd.'`=dir`'
  endtry
endfunction

function! s:Git(bang,cmd) abort
  if a:bang
    return s:Edit('edit',1,a:cmd)
  endif
  let git = s:repo().git_command()
  if has('gui_running') && !has('win32')
    let git .= ' --no-pager'
  endif
  let cmd = matchstr(a:cmd,'\v\C.{-}%($|\\@<!%(\\\\)*\|)@=')
  call s:ExecuteInTree('!'.git.' '.cmd)
  call fugitive#reload_status()
  return matchstr(a:cmd,'\v\C\\@<!%(\\\\)*\|\zs.*')
endfunction

function! s:GitComplete(A,L,P) abort
  if !exists('s:exec_path')
    let s:exec_path = s:sub(system(g:fugitive_git_executable.' --exec-path'),'\n$','')
  endif
  let cmds = map(split(glob(s:exec_path.'/git-*'),"\n"),'s:sub(v:val[strlen(s:exec_path)+5 : -1],"\\.exe$","")')
  if a:L =~ ' [[:alnum:]-]\+ '
    return s:repo().superglob(a:A)
  elseif a:A == ''
    return sort(cmds+keys(s:repo().aliases()))
  else
    return filter(sort(cmds+keys(s:repo().aliases())),'v:val[0:strlen(a:A)-1] ==# a:A')
  endif
endfunction

" }}}1
" Gcd, Glcd {{{1

function! s:DirComplete(A,L,P) abort
  let matches = s:repo().dirglob(a:A)
  return matches
endfunction

call s:command("-bar -bang -nargs=? -complete=customlist,s:DirComplete Gcd  :cd<bang>  `=s:repo().bare() ? s:repo().dir(<q-args>) : s:repo().tree(<q-args>)`")
call s:command("-bar -bang -nargs=? -complete=customlist,s:DirComplete Glcd :lcd<bang> `=s:repo().bare() ? s:repo().dir(<q-args>) : s:repo().tree(<q-args>)`")

" }}}1
" Gstatus {{{1

call s:command("-bar Gstatus :execute s:Status()")

function! s:Status() abort
  try
    Gpedit :
    wincmd P
    nnoremap <buffer> <silent> q    :<C-U>bdelete<CR>
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
  return ''
endfunction

function! fugitive#reload_status() abort
  let mytab = tabpagenr()
  for tab in [mytab] + range(1,tabpagenr('$'))
    for winnr in range(1,tabpagewinnr(tab,'$'))
      if getbufvar(tabpagebuflist(tab)[winnr-1],'fugitive_type') ==# 'index'
        execute 'tabnext '.tab
        if winnr != winnr()
          execute winnr.'wincmd w'
          let restorewinnr = 1
        endif
        try
          if !&modified
            call s:BufReadIndex()
          endif
        finally
          if exists('restorewinnr')
            wincmd p
          endif
          execute 'tabnext '.mytab
        endtry
      endif
    endfor
  endfor
endfunction

function! s:StageReloadSeek(target,lnum1,lnum2)
  let jump = a:target
  let f = matchstr(getline(a:lnum1-1),'^#\t\%([[:alpha:] ]\+: *\)\=\zs.*')
  if f !=# '' | let jump = f | endif
  let f = matchstr(getline(a:lnum2+1),'^#\t\%([[:alpha:] ]\+: *\)\=\zs.*')
  if f !=# '' | let jump = f | endif
  silent! edit!
  1
  redraw
  call search('^#\t\%([[:alpha:] ]\+: *\)\=\V'.jump.'\%( (new commits)\)\=\$','W')
endfunction

function! s:StageDiff(diff) abort
  let section = getline(search('^# .*:$','bcnW'))
  let line = getline('.')
  let filename = matchstr(line,'^#\t\%([[:alpha:] ]\+: *\)\=\zs.\{-\}\ze\%( (new commits)\)\=$')
  if filename ==# '' && section ==# '# Changes to be committed:'
    return 'Git diff --cached'
  elseif filename ==# ''
    return 'Git diff'
  elseif line =~# '^#\trenamed:' && filename =~# ' -> '
    let [old, new] = split(filename,' -> ')
    execute 'Gedit '.s:fnameescape(':0:'.new)
    return a:diff.' HEAD:'.s:fnameescape(old)
  elseif section ==# '# Changes to be committed:'
    execute 'Gedit '.s:fnameescape(':0:'.filename)
    return a:diff.' -'
  else
    execute 'Gedit '.s:fnameescape('/'.filename)
    return a:diff
  endif
endfunction

function! s:StageDiffEdit() abort
  let section = getline(search('^# .*:$','bcnW'))
  let line = getline('.')
  let filename = matchstr(line,'^#\t\%([[:alpha:] ]\+: *\)\=\zs.\{-\}\ze\%( (new commits)\)\=$')
  let arg = (filename ==# '' ? '.' : filename)
  if section ==# '# Changes to be committed:'
    return 'Git! diff --cached '.s:shellesc(arg)
  elseif section ==# '# Untracked files:'
    let repo = s:repo()
    call repo.git_chomp_in_tree('add','--intent-to-add',arg)
    if arg ==# '.'
      silent! edit!
      1
      if !search('^# Change\%(d but not updated\|s not staged for commit\):$','W')
        call search('^# Change','W')
      endif
    else
      call s:StageReloadSeek(arg,line('.'),line('.'))
    endif
    return ''
  else
    return 'Git! diff '.s:shellesc(arg)
  endif
endfunction

function! s:StageToggle(lnum1,lnum2) abort
  try
    let output = ''
    for lnum in range(a:lnum1,a:lnum2)
      let line = getline(lnum)
      let repo = s:repo()
      if line ==# '# Changes to be committed:'
        call repo.git_chomp_in_tree('reset','-q')
        silent! edit!
        1
        if !search('^# Untracked files:$','W')
          call search('^# Change','W')
        endif
        return ''
      elseif line =~# '^# Change\%(d but not updated\|s not staged for commit\):$'
        call repo.git_chomp_in_tree('add','-u')
        silent! edit!
        1
        if !search('^# Untracked files:$','W')
          call search('^# Change','W')
        endif
        return ''
      elseif line ==# '# Untracked files:'
        call repo.git_chomp_in_tree('add','.')
        silent! edit!
        1
        call search('^# Change','W')
        return ''
      endif
      let filename = matchstr(line,'^#\t\%([[:alpha:] ]\+: *\)\=\zs.\{-\}\ze\%( (\a\+ [[:alpha:], ]\+)\)\=$')
      if filename ==# ''
        continue
      endif
      if !exists('first_filename')
        let first_filename = filename
      endif
      execute lnum
      let section = getline(search('^# .*:$','bnW'))
      if line =~# '^#\trenamed:' && filename =~ ' -> '
        let cmd = ['mv','--'] + reverse(split(filename,' -> '))
        let filename = cmd[-1]
      elseif section =~? ' to be '
        let cmd = ['reset','-q','--',filename]
      elseif line =~# '^#\tdeleted:'
        let cmd = ['rm','--',filename]
      else
        let cmd = ['add','--',filename]
      endif
      let output .= call(repo.git_chomp_in_tree,cmd,s:repo())."\n"
    endfor
    if exists('first_filename')
      call s:StageReloadSeek(first_filename,a:lnum1,a:lnum2)
    endif
    echo s:sub(s:gsub(output,'\n+','\n'),'\n$','')
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
  return 'checktime'
endfunction

function! s:StagePatch(lnum1,lnum2) abort
  let add = []
  let reset = []

  for lnum in range(a:lnum1,a:lnum2)
    let line = getline(lnum)
    if line ==# '# Changes to be committed:'
      return 'Git reset --patch'
    elseif line =~# '^# Change\%(d but not updated\|s not staged for commit\):$'
      return 'Git add --patch'
    endif
    let filename = matchstr(line,'^#\t\%([[:alpha:] ]\+: *\)\=\zs.\{-\}\ze\%( (new commits)\)\=$')
    if filename ==# ''
      continue
    endif
    if !exists('first_filename')
      let first_filename = filename
    endif
    execute lnum
    let section = getline(search('^# .*:$','bnW'))
    if line =~# '^#\trenamed:' && filename =~ ' -> '
      let reset += [split(filename,' -> ')[1]]
    elseif section =~? ' to be '
      let reset += [filename]
    elseif line !~# '^#\tdeleted:'
      let add += [filename]
    endif
  endfor
  try
    if !empty(add)
      execute "Git add --patch -- ".join(map(add,'s:shellesc(v:val)'))
    endif
    if !empty(reset)
      execute "Git reset --patch -- ".join(map(add,'s:shellesc(v:val)'))
    endif
    if exists('first_filename')
      silent! edit!
      1
      redraw
      call search('^#\t\%([[:alpha:] ]\+: *\)\=\V'.first_filename.'\%( (new commits)\)\=\$','W')
    endif
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
  return 'checktime'
endfunction

" }}}1
" Gcommit {{{1

call s:command("-nargs=? -complete=customlist,s:CommitComplete Gcommit :execute s:Commit(<q-args>)")

function! s:Commit(args) abort
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
  let dir = getcwd()
  let msgfile = s:repo().dir('COMMIT_EDITMSG')
  let outfile = tempname()
  let errorfile = tempname()
  try
    execute cd.'`=s:repo().tree()`'
    if &shell =~# 'cmd'
      let command = ''
      let old_editor = $GIT_EDITOR
      let $GIT_EDITOR = 'false'
    else
      let command = 'env GIT_EDITOR=false '
    endif
    let command .= s:repo().git_command('commit').' '.a:args
    if &shell =~# 'csh'
      silent execute '!('.command.' > '.outfile.') >& '.errorfile
    elseif a:args =~# '\%(^\| \)--interactive\>'
      execute '!'.command.' 2> '.errorfile
    else
      silent execute '!'.command.' > '.outfile.' 2> '.errorfile
    endif
    if !has('gui_running')
      redraw!
    endif
    if !v:shell_error
      if filereadable(outfile)
        for line in readfile(outfile)
          echo line
        endfor
      endif
      return ''
    else
      let errors = readfile(errorfile)
      let error = get(errors,-2,get(errors,-1,'!'))
      if error =~# '\<false''\=\.$'
        let args = a:args
        let args = s:gsub(args,'%(%(^| )-- )@<!%(^| )@<=%(-[se]|--edit|--interactive)%($| )','')
        let args = s:gsub(args,'%(%(^| )-- )@<!%(^| )@<=%(-F|--file|-m|--message)%(\s+|\=)%(''[^'']*''|"%(\\.|[^"])*"|\\.|\S)*','')
        let args = s:gsub(args,'%(^| )@<=[%#]%(:\w)*','\=expand(submatch(0))')
        let args = '-F '.s:shellesc(msgfile).' '.args
        if args !~# '\%(^\| \)--cleanup\>'
          let args = '--cleanup=strip '.args
        endif
        if bufname('%') == '' && line('$') == 1 && getline(1) == '' && !&mod
          keepalt edit `=msgfile`
        elseif s:buffer().type() ==# 'index'
          keepalt edit `=msgfile`
          execute (search('^#','n')+1).'wincmd+'
          setlocal nopreviewwindow
        else
          keepalt split `=msgfile`
        endif
        let b:fugitive_commit_arguments = args
        setlocal bufhidden=delete filetype=gitcommit
        return '1'
      elseif error ==# '!'
        return s:Status()
      else
        call s:throw(error)
      endif
    endif
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  finally
    if exists('old_editor')
      let $GIT_EDITOR = old_editor
    endif
    call delete(outfile)
    call delete(errorfile)
    execute cd.'`=dir`'
    call fugitive#reload_status()
  endtry
endfunction

function! s:CommitComplete(A,L,P) abort
  if a:A =~ '^-' || type(a:A) == type(0) " a:A is 0 on :Gcommit -<Tab>
    let args = ['-C', '-F', '-a', '-c', '-e', '-i', '-m', '-n', '-o', '-q', '-s', '-t', '-u', '-v', '--all', '--allow-empty', '--amend', '--author=', '--cleanup=', '--dry-run', '--edit', '--file=', '--include', '--interactive', '--message=', '--no-verify', '--only', '--quiet', '--reedit-message=', '--reuse-message=', '--signoff', '--template=', '--untracked-files', '--verbose']
    return filter(args,'v:val[0 : strlen(a:A)-1] ==# a:A')
  else
    return s:repo().superglob(a:A)
  endif
endfunction

function! s:FinishCommit()
  let args = getbufvar(+expand('<abuf>'),'fugitive_commit_arguments')
  if !empty(args)
    call setbufvar(+expand('<abuf>'),'fugitive_commit_arguments','')
    return s:Commit(args)
  endif
  return ''
endfunction

augroup fugitive_commit
  autocmd!
  autocmd VimLeavePre,BufDelete *.git/COMMIT_EDITMSG execute s:sub(s:FinishCommit(), '^echoerr (.*)', 'echohl ErrorMsg|echo \1|echohl NONE')
augroup END

" }}}1
" Ggrep, Glog {{{1

if !exists('g:fugitive_summary_format')
  let g:fugitive_summary_format = '%s'
endif

call s:command("-bang -nargs=? -complete=customlist,s:EditComplete Ggrep :execute s:Grep(<bang>0,<q-args>)")
call s:command("-bar -bang -nargs=* -complete=customlist,s:EditComplete Glog :execute s:Log('grep<bang>',<f-args>)")

function! s:Grep(bang,arg) abort
  let grepprg = &grepprg
  let grepformat = &grepformat
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
  let dir = getcwd()
  try
    execute cd.'`=s:repo().tree()`'
    let &grepprg = s:repo().git_command('--no-pager', 'grep', '-n')
    let &grepformat = '%f:%l:%m'
    exe 'grep! '.escape(matchstr(a:arg,'\v\C.{-}%($|[''" ]\@=\|)@='),'|')
    let list = getqflist()
    for entry in list
      if bufname(entry.bufnr) =~ ':'
        let entry.filename = s:repo().translate(bufname(entry.bufnr))
        unlet! entry.bufnr
      elseif a:arg =~# '\%(^\| \)--cached\>'
        let entry.filename = s:repo().translate(':0:'.bufname(entry.bufnr))
        unlet! entry.bufnr
      endif
    endfor
    call setqflist(list,'r')
    if !a:bang && !empty(list)
      return 'cfirst'.matchstr(a:arg,'\v\C[''" ]\zs\|.*')
    else
      return matchstr(a:arg,'\v\C[''" ]\|\zs.*')
    endif
  finally
    let &grepprg = grepprg
    let &grepformat = grepformat
    execute cd.'`=dir`'
  endtry
endfunction

function! s:Log(cmd,...)
  let path = s:buffer().path('/')
  if path =~# '^/\.git\%(/\|$\)' || index(a:000,'--') != -1
    let path = ''
  endif
  let cmd = ['--no-pager', 'log', '--no-color']
  let cmd += [escape('--pretty=format:fugitive://'.s:repo().dir().'//%H'.path.'::'.g:fugitive_summary_format,'%')]
  if empty(filter(a:000[0 : index(a:000,'--')],'v:val !~# "^-"'))
    if s:buffer().commit() =~# '\x\{40\}'
      let cmd += [s:buffer().commit()]
    elseif s:buffer().path() =~# '^\.git/refs/\|^\.git/.*HEAD$'
      let cmd += [s:buffer().path()[5:-1]]
    endif
  end
  let cmd += map(copy(a:000),'s:sub(v:val,"^\\%(%(:\\w)*)","\\=fnamemodify(s:buffer().path(),submatch(1))")')
  if path =~# '/.'
    let cmd += ['--',path[1:-1]]
  endif
  let grepformat = &grepformat
  let grepprg = &grepprg
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
  let dir = getcwd()
  try
    execute cd.'`=s:repo().tree()`'
    let &grepprg = call(s:repo().git_command,cmd,s:repo())
    let &grepformat = '%f::%m'
    exe a:cmd
  finally
    let &grepformat = grepformat
    let &grepprg = grepprg
    execute cd.'`=dir`'
  endtry
endfunction

" }}}1
" Gedit, Gpedit, Gsplit, Gvsplit, Gtabedit, Gread {{{1

function! s:Edit(cmd,bang,...) abort
  if a:cmd !~# 'read'
    if &previewwindow && getbufvar('','fugitive_type') ==# 'index'
      wincmd p
      if &diff
        let mywinnr = winnr()
        for winnr in range(winnr('$'),1,-1)
          if winnr != mywinnr && getwinvar(winnr,'&diff')
            execute winnr.'wincmd w'
            close
            wincmd p
          endif
        endfor
      endif
    endif
  endif

  if a:bang
    let args = s:gsub(a:0 ? a:1 : '', '\\@<!%(\\\\)*\zs[%#]', '\=s:buffer().expand(submatch(0))')
    if a:cmd =~# 'read'
      let git = s:repo().git_command()
      let last = line('$')
      silent call s:ExecuteInTree((a:cmd ==# 'read' ? '$read' : a:cmd).'!'.git.' --no-pager '.args)
      if a:cmd ==# 'read'
        silent execute '1,'.last.'delete_'
      endif
      call fugitive#reload_status()
      diffupdate
      return 'redraw|echo '.string(':!'.git.' '.args)
    else
      let temp = resolve(tempname())
      let s:temp_files[temp] = s:repo().dir()
      silent execute a:cmd.' '.temp
      if a:cmd =~# 'pedit'
        wincmd P
      endif
      let echo = s:Edit('read',1,args)
      silent write!
      setlocal buftype=nowrite nomodified filetype=git foldmarker=<<<<<<<,>>>>>>>
      if getline(1) !~# '^diff '
        setlocal readonly nomodifiable
      endif
      if a:cmd =~# 'pedit'
        wincmd p
      endif
      return echo
    endif
    return ''
  endif

  if a:0 && a:1 == ''
    return ''
  elseif a:0
    let file = s:buffer().expand(a:1)
  elseif expand('%') ==# ''
    let file = ':'
  elseif s:buffer().commit() ==# '' && s:buffer().path('/') !~# '^/.git\>'
    let file = s:buffer().path(':')
  else
    let file = s:buffer().path('/')
  endif
  try
    let file = s:repo().translate(file)
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
  if a:cmd ==# 'read'
    return 'silent %delete_|read '.s:fnameescape(file).'|silent 1delete_|diffupdate|'.line('.')
  else
    return a:cmd.' '.s:fnameescape(file)
  endif
endfunction

function! s:EditComplete(A,L,P) abort
  return s:repo().superglob(a:A)
endfunction

function! s:EditRunComplete(A,L,P) abort
  if a:L =~# '^\w\+!'
    return s:GitComplete(a:A,a:L,a:P)
  else
    return s:repo().superglob(a:A)
  endif
endfunction

call s:command("-bar -bang -nargs=? -complete=customlist,s:EditComplete Ge       :execute s:Edit('edit<bang>',0,<f-args>)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:EditComplete Gedit    :execute s:Edit('edit<bang>',0,<f-args>)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:EditRunComplete Gpedit   :execute s:Edit('pedit',<bang>0,<f-args>)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:EditRunComplete Gsplit   :execute s:Edit('split',<bang>0,<f-args>)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:EditRunComplete Gvsplit  :execute s:Edit('vsplit',<bang>0,<f-args>)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:EditRunComplete Gtabedit :execute s:Edit('tabedit',<bang>0,<f-args>)")
call s:command("-bar -bang -nargs=? -count -complete=customlist,s:EditRunComplete Gread :execute s:Edit((!<count> && <line1> ? '' : <count>).'read',<bang>0,<f-args>)")

" }}}1
" Gwrite, Gwq {{{1

call s:command("-bar -bang -nargs=? -complete=customlist,s:EditComplete Gwrite :execute s:Write(<bang>0,<f-args>)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:EditComplete Gw :execute s:Write(<bang>0,<f-args>)")
call s:command("-bar -bang -nargs=? -complete=customlist,s:EditComplete Gwq :execute s:Wq(<bang>0,<f-args>)")

function! s:Write(force,...) abort
  if exists('b:fugitive_commit_arguments')
    return 'write|bdelete'
  elseif expand('%:t') == 'COMMIT_EDITMSG' && $GIT_INDEX_FILE != ''
    return 'wq'
  elseif s:buffer().type() == 'index'
    return 'Gcommit'
  elseif s:buffer().path() ==# '' && getline(4) =~# '^+++ '
    let filename = getline(4)[6:-1]
    setlocal buftype=
    silent write
    setlocal buftype=nowrite
    if matchstr(getline(2),'index [[:xdigit:]]\+\.\.\zs[[:xdigit:]]\{7\}') ==# s:repo().rev_parse(':0:'.filename)[0:6]
      let err = s:repo().git_chomp('apply','--cached','--reverse',s:buffer().spec())
    else
      let err = s:repo().git_chomp('apply','--cached',s:buffer().spec())
    endif
    if err !=# ''
      let v:errmsg = split(err,"\n")[0]
      return 'echoerr v:errmsg'
    elseif a:force
      return 'bdelete'
    else
      return 'Gedit '.fnameescape(filename)
    endif
  endif
  let mytab = tabpagenr()
  let mybufnr = bufnr('')
  let path = a:0 ? a:1 : s:buffer().path()
  if path =~# '^:\d\>'
    return 'write'.(a:force ? '! ' : ' ').s:fnameescape(s:repo().translate(s:buffer().expand(path)))
  endif
  let always_permitted = (s:buffer().path() ==# path && s:buffer().commit() =~# '^0\=$')
  if !always_permitted && !a:force && s:repo().git_chomp_in_tree('diff','--name-status','HEAD','--',path) . s:repo().git_chomp_in_tree('ls-files','--others','--',path) !=# ''
    let v:errmsg = 'fugitive: file has uncommitted changes (use ! to override)'
    return 'echoerr v:errmsg'
  endif
  let file = s:repo().translate(path)
  let treebufnr = 0
  for nr in range(1,bufnr('$'))
    if fnamemodify(bufname(nr),':p') ==# file
      let treebufnr = nr
    endif
  endfor

  if treebufnr > 0 && treebufnr != bufnr('')
    let temp = tempname()
    silent execute '%write '.temp
    for tab in [mytab] + range(1,tabpagenr('$'))
      for winnr in range(1,tabpagewinnr(tab,'$'))
        if tabpagebuflist(tab)[winnr-1] == treebufnr
          execute 'tabnext '.tab
          if winnr != winnr()
            execute winnr.'wincmd w'
            let restorewinnr = 1
          endif
          try
            let lnum = line('.')
            let last = line('$')
            silent execute '$read '.temp
            silent execute '1,'.last.'delete_'
            silent write!
            silent execute lnum
            let did = 1
          finally
            if exists('restorewinnr')
              wincmd p
            endif
            execute 'tabnext '.mytab
          endtry
        endif
      endfor
    endfor
    if !exists('did')
      call writefile(readfile(temp,'b'),file,'b')
    endif
  else
    execute 'write! '.s:fnameescape(s:repo().translate(path))
  endif

  if a:force
    let error = s:repo().git_chomp_in_tree('add', '--force', file)
  else
    let error = s:repo().git_chomp_in_tree('add', file)
  endif
  if v:shell_error
    let v:errmsg = 'fugitive: '.error
    return 'echoerr v:errmsg'
  endif
  if s:buffer().path() ==# path && s:buffer().commit() =~# '^\d$'
    set nomodified
  endif

  let one = s:repo().translate(':1:'.path)
  let two = s:repo().translate(':2:'.path)
  let three = s:repo().translate(':3:'.path)
  for nr in range(1,bufnr('$'))
    if bufloaded(nr) && !getbufvar(nr,'&modified') && (bufname(nr) == one || bufname(nr) == two || bufname(nr) == three)
      execute nr.'bdelete'
    endif
  endfor

  unlet! restorewinnr
  let zero = s:repo().translate(':0:'.path)
  for tab in range(1,tabpagenr('$'))
    for winnr in range(1,tabpagewinnr(tab,'$'))
      let bufnr = tabpagebuflist(tab)[winnr-1]
      let bufname = bufname(bufnr)
      if bufname ==# zero && bufnr != mybufnr
        execute 'tabnext '.tab
        if winnr != winnr()
          execute winnr.'wincmd w'
          let restorewinnr = 1
        endif
        try
          let lnum = line('.')
          let last = line('$')
          silent $read `=file`
          silent execute '1,'.last.'delete_'
          silent execute lnum
          set nomodified
          diffupdate
        finally
          if exists('restorewinnr')
            wincmd p
          endif
          execute 'tabnext '.mytab
        endtry
        break
      endif
    endfor
  endfor
  call fugitive#reload_status()
  return 'checktime'
endfunction

function! s:Wq(force,...) abort
  let bang = a:force ? '!' : ''
  if exists('b:fugitive_commit_arguments')
    return 'wq'.bang
  endif
  let result = call(s:function('s:Write'),[a:force]+a:000)
  if result =~# '^\%(write\|wq\|echoerr\)'
    return s:sub(result,'^write','wq')
  else
    return result.'|quit'.bang
  endif
endfunction

" }}}1
" Gdiff {{{1

call s:command("-bang -bar -nargs=? -complete=customlist,s:EditComplete Gdiff :execute s:Diff(<bang>0,<f-args>)")
call s:command("-bar -nargs=? -complete=customlist,s:EditComplete Gvdiff :execute s:Diff(0,<f-args>)")
call s:command("-bar -nargs=? -complete=customlist,s:EditComplete Gsdiff :execute s:Diff(1,<f-args>)")

augroup fugitive_diff
  autocmd!
  autocmd BufWinLeave * if s:diff_window_count() == 2 && &diff && getbufvar(+expand('<abuf>'), 'git_dir') !=# '' | call s:diffoff_all(getbufvar(+expand('<abuf>'), 'git_dir')) | endif
  autocmd BufWinEnter * if s:diff_window_count() == 1 && &diff && getbufvar(+expand('<abuf>'), 'git_dir') !=# '' | call s:diffoff() | endif
augroup END

function! s:diff_window_count()
  let c = 0
  for nr in range(1,winnr('$'))
    let c += getwinvar(nr,'&diff')
  endfor
  return c
endfunction

function! s:diffthis()
  if !&diff
    let w:fugitive_diff_restore = 'setlocal nodiff noscrollbind'
    let w:fugitive_diff_restore .= ' scrollopt=' . &l:scrollopt
    let w:fugitive_diff_restore .= &l:wrap ? ' wrap' : ' nowrap'
    let w:fugitive_diff_restore .= ' foldmethod=' . &l:foldmethod
    let w:fugitive_diff_restore .= ' foldcolumn=' . &l:foldcolumn
    if has('cursorbind')
      let w:fugitive_diff_restore .= (&l:cursorbind ? ' ' : ' no') . 'cursorbind'
    endif
    diffthis
  endif
endfunction

function! s:diffoff()
  if exists('w:fugitive_diff_restore')
    execute w:fugitive_diff_restore
    unlet w:fugitive_diff_restore
  else
    diffoff
  endif
endfunction

function! s:diffoff_all(dir)
  for nr in range(1,winnr('$'))
    if getwinvar(nr,'&diff')
      if nr != winnr()
        execute nr.'wincmd w'
        let restorewinnr = 1
      endif
      if exists('b:git_dir') && b:git_dir ==# a:dir
        call s:diffoff()
      endif
      if exists('restorewinnr')
        wincmd p
      endif
    endif
  endfor
endfunction

function! s:buffer_compare_age(commit) dict abort
  let scores = {':0': 1, ':1': 2, ':2': 3, ':': 4, ':3': 5}
  let my_score    = get(scores,':'.self.commit(),0)
  let their_score = get(scores,':'.a:commit,0)
  if my_score || their_score
    return my_score < their_score ? -1 : my_score != their_score
  elseif self.commit() ==# a:commit
    return 0
  endif
  let base = self.repo().git_chomp('merge-base',self.commit(),a:commit)
  if base ==# self.commit()
    return -1
  elseif base ==# a:commit
    return 1
  endif
  let my_time    = +self.repo().git_chomp('log','--max-count=1','--pretty=format:%at',self.commit())
  let their_time = +self.repo().git_chomp('log','--max-count=1','--pretty=format:%at',a:commit)
  return my_time < their_time ? -1 : my_time != their_time
endfunction

call s:add_methods('buffer',['compare_age'])

function! s:Diff(bang,...) abort
  let split = a:bang ? 'split' : 'vsplit'
  if exists(':DiffGitCached')
    return 'DiffGitCached'
  elseif (!a:0 || a:1 == ':') && s:buffer().commit() =~# '^[0-1]\=$' && s:repo().git_chomp_in_tree('ls-files', '--unmerged', '--', s:buffer().path()) !=# ''
    let nr = bufnr('')
    execute 'leftabove '.split.' `=fugitive#buffer().repo().translate(s:buffer().expand('':2''))`'
    execute 'nnoremap <buffer> <silent> dp :diffput '.nr.'<Bar>diffupdate<CR>'
    call s:diffthis()
    wincmd p
    execute 'rightbelow '.split.' `=fugitive#buffer().repo().translate(s:buffer().expand('':3''))`'
    execute 'nnoremap <buffer> <silent> dp :diffput '.nr.'<Bar>diffupdate<CR>'
    call s:diffthis()
    wincmd p
    call s:diffthis()
    return ''
  elseif a:0
    if a:1 ==# ''
      return ''
    elseif a:1 ==# '/'
      let file = s:buffer().path('/')
    elseif a:1 ==# ':'
      let file = s:buffer().path(':0:')
    elseif a:1 =~# '^:/.'
      try
        let file = s:repo().rev_parse(a:1).s:buffer().path(':')
      catch /^fugitive:/
        return 'echoerr v:errmsg'
      endtry
    else
      let file = s:buffer().expand(a:1)
    endif
    if file !~# ':' && file !~# '^/' && s:repo().git_chomp('cat-file','-t',file) =~# '^\%(tag\|commit\)$'
      let file = file.s:buffer().path(':')
    endif
  else
    let file = s:buffer().path(s:buffer().commit() == '' ? ':0:' : '/')
  endif
  try
    let spec = s:repo().translate(file)
    let commit = matchstr(spec,'\C[^:/]//\zs\x\+')
    if s:buffer().compare_age(commit) < 0
      execute 'rightbelow '.split.' `=spec`'
    else
      execute 'leftabove '.split.' `=spec`'
    endif
    call s:diffthis()
    wincmd p
    call s:diffthis()
    return ''
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

" }}}1
" Gmove, Gremove {{{1

function! s:Move(force,destination)
  if a:destination =~# '^/'
    let destination = a:destination[1:-1]
  else
    let destination = fnamemodify(s:sub(a:destination,'[%#]%(:\w)*','\=expand(submatch(0))'),':p')
    if destination[0:strlen(s:repo().tree())] ==# s:repo().tree('')
      let destination = destination[strlen(s:repo().tree('')):-1]
    endif
  endif
  if isdirectory(s:buffer().name())
    " Work around Vim parser idiosyncrasy
    let discarded = s:buffer().setvar('&swapfile',0)
  endif
  let message = call(s:repo().git_chomp_in_tree,['mv']+(a:force ? ['-f'] : [])+['--', s:buffer().path(), destination], s:repo())
  if v:shell_error
    let v:errmsg = 'fugitive: '.message
    return 'echoerr v:errmsg'
  endif
  let destination = s:repo().tree(destination)
  if isdirectory(destination)
    let destination = fnamemodify(s:sub(destination,'/$','').'/'.expand('%:t'),':.')
  endif
  call fugitive#reload_status()
  if s:buffer().commit() == ''
    if isdirectory(destination)
      return 'edit '.s:fnameescape(destination)
    else
      return 'saveas! '.s:fnameescape(destination)
    endif
  else
    return 'file '.s:fnameescape(s:repo().translate(':0:'.destination)
  endif
endfunction

function! s:MoveComplete(A,L,P)
  if a:A =~ '^/'
    return s:repo().superglob(a:A)
  else
    let matches = split(glob(a:A.'*'),"\n")
    call map(matches,'v:val !~ "/$" && isdirectory(v:val) ? v:val."/" : v:val')
    return matches
  endif
endfunction

function! s:Remove(force)
  if s:buffer().commit() ==# ''
    let cmd = ['rm']
  elseif s:buffer().commit() ==# '0'
    let cmd = ['rm','--cached']
  else
    let v:errmsg = 'fugitive: rm not supported here'
    return 'echoerr v:errmsg'
  endif
  if a:force
    let cmd += ['--force']
  endif
  let message = call(s:repo().git_chomp_in_tree,cmd+['--',s:buffer().path()],s:repo())
  if v:shell_error
    let v:errmsg = 'fugitive: '.s:sub(message,'error:.*\zs\n\(.*-f.*',' (add ! to force)')
    return 'echoerr '.string(v:errmsg)
  else
    call fugitive#reload_status()
    return 'bdelete'.(a:force ? '!' : '')
  endif
endfunction

augroup fugitive_remove
  autocmd!
  autocmd User Fugitive if s:buffer().commit() =~# '^0\=$' |
        \ exe "command! -buffer -bar -bang -nargs=1 -complete=customlist,s:MoveComplete Gmove :execute s:Move(<bang>0,<q-args>)" |
        \ exe "command! -buffer -bar -bang Gremove :execute s:Remove(<bang>0)" |
        \ endif
augroup END

" }}}1
" Gblame {{{1

augroup fugitive_blame
  autocmd!
  autocmd BufReadPost *.fugitiveblame setfiletype fugitiveblame
  autocmd FileType fugitiveblame setlocal nomodeline | if exists('b:git_dir') | let &l:keywordprg = s:repo().keywordprg() | endif
  autocmd Syntax fugitiveblame call s:BlameSyntax()
  autocmd User Fugitive if s:buffer().type('file', 'blob') | exe "command! -buffer -bar -bang -range=0 -nargs=* Gblame :execute s:Blame(<bang>0,<line1>,<line2>,<count>,[<f-args>])" | endif
augroup END

function! s:Blame(bang,line1,line2,count,args) abort
  try
    if s:buffer().path() == ''
      call s:throw('file or blob required')
    endif
    if filter(copy(a:args),'v:val !~# "^\\%(--root\|--show-name\\|-\\=\\%([ltwfs]\\|[MC]\\d*\\)\\+\\)$"') != []
      call s:throw('unsupported option')
    endif
    call map(a:args,'s:sub(v:val,"^\\ze[^-]","-")')
    let cmd = ['--no-pager', 'blame', '--show-number'] + a:args
    if s:buffer().commit() =~# '\D\|..'
      let cmd += [s:buffer().commit()]
    else
      let cmd += ['--contents', '-']
    endif
    let basecmd = escape(call(s:repo().git_command,cmd+['--',s:buffer().path()],s:repo()),'!')
    try
      let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
      if !s:repo().bare()
        let dir = getcwd()
        execute cd.'`=s:repo().tree()`'
      endif
      if a:count
        execute 'write !'.substitute(basecmd,' blame ',' blame -L '.a:line1.','.a:line2.' ','g')
      else
        let error = resolve(tempname())
        let temp = error.'.fugitiveblame'
        if &shell =~# 'csh'
          silent! execute '%write !('.basecmd.' > '.temp.') >& '.error
        else
          silent! execute '%write !'.basecmd.' > '.temp.' 2> '.error
        endif
        if exists('l:dir')
          execute cd.'`=dir`'
          unlet dir
        endif
        if v:shell_error
          call s:throw(join(readfile(error),"\n"))
        endif
        for winnr in range(winnr('$'),1,-1)
          call setwinvar(winnr, '&scrollbind', 0)
          if getbufvar(winbufnr(winnr), 'fugitive_blamed_bufnr')
            execute winbufnr(winnr).'bdelete'
          endif
        endfor
        let bufnr = bufnr('')
        let restore = 'call setwinvar(bufwinnr('.bufnr.'),"&scrollbind",0)'
        if &l:wrap
          let restore .= '|call setwinvar(bufwinnr('.bufnr.'),"&wrap",1)'
        endif
        if &l:foldenable
          let restore .= '|call setwinvar(bufwinnr('.bufnr.'),"&foldenable",1)'
        endif
        setlocal scrollbind nowrap nofoldenable
        let top = line('w0') + &scrolloff
        let current = line('.')
        let s:temp_files[temp] = s:repo().dir()
        exe 'leftabove vsplit '.temp
        let b:fugitive_blamed_bufnr = bufnr
        let w:fugitive_leave = restore
        let b:fugitive_blame_arguments = join(a:args,' ')
        execute top
        normal! zt
        execute current
        execute "vertical resize ".(match(getline('.'),'\s\+\d\+)')+1)
        setlocal nomodified nomodifiable nonumber scrollbind nowrap foldcolumn=0 nofoldenable filetype=fugitiveblame
        if exists('+relativenumber')
          setlocal norelativenumber
        endif
        nnoremap <buffer> <silent> q    :exe substitute('bdelete<Bar>'.bufwinnr(b:fugitive_blamed_bufnr).' wincmd w','<Bar>-1','','')<CR>
        nnoremap <buffer> <silent> gq   :exe substitute('bdelete<Bar>'.bufwinnr(b:fugitive_blamed_bufnr).' wincmd w<Bar>if expand("%:p") =~# "^fugitive:[\\/][\\/]"<Bar>Gedit<Bar>endif','<Bar>-1','','')<CR>
        nnoremap <buffer> <silent> <CR> :<C-U>exe <SID>BlameJump('')<CR>
        nnoremap <buffer> <silent> P    :<C-U>exe <SID>BlameJump('^'.v:count1)<CR>
        nnoremap <buffer> <silent> ~    :<C-U>exe <SID>BlameJump('~'.v:count1)<CR>
        nnoremap <buffer> <silent> i    :<C-U>exe <SID>BlameCommit("exe 'norm q'<Bar>edit")<CR>
        nnoremap <buffer> <silent> o    :<C-U>exe <SID>BlameCommit((&splitbelow ? "botright" : "topleft")." split")<CR>
        nnoremap <buffer> <silent> O    :<C-U>exe <SID>BlameCommit("tabedit")<CR>
        redraw
        syncbind
      endif
    finally
      if exists('l:dir')
        execute cd.'`=dir`'
      endif
    endtry
    return ''
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

function! s:BlameCommit(cmd) abort
  let cmd = s:Edit(a:cmd, 0, matchstr(getline('.'),'\x\+'))
  if cmd =~# '^echoerr'
    return cmd
  endif
  let lnum = matchstr(getline('.'),' \zs\d\+\ze\s\+[([:digit:]]')
  let path = matchstr(getline('.'),'^\^\=\x\+\s\+\zs.\{-\}\ze\s*\d\+ ')
  if path ==# ''
    let path = s:buffer(b:fugitive_blamed_bufnr).path()
  endif
  execute cmd
  if search('^diff .* b/\M'.escape(path,'\').'$','W')
    call search('^+++')
    let head = line('.')
    while search('^@@ \|^diff ') && getline('.') =~# '^@@ '
      let top = +matchstr(getline('.'),' +\zs\d\+')
      let len = +matchstr(getline('.'),' +\d\+,\zs\d\+')
      if lnum >= top && lnum <= top + len
        let offset = lnum - top
        if &scrolloff
          +
          normal! zt
        else
          normal! zt
          +
        endif
        while offset > 0 && line('.') < line('$')
          +
          if getline('.') =~# '^[ +]'
            let offset -= 1
          endif
        endwhile
        return ''
      endif
    endwhile
    execute head
    normal! zt
  endif
  return ''
endfunction

function! s:BlameJump(suffix) abort
  let commit = matchstr(getline('.'),'^\^\=\zs\x\+')
  if commit =~# '^0\+$'
    let commit = ':0'
  endif
  let lnum = matchstr(getline('.'),' \zs\d\+\ze\s\+[([:digit:]]')
  let path = matchstr(getline('.'),'^\^\=\x\+\s\+\zs.\{-\}\ze\s*\d\+ ')
  if path ==# ''
    let path = s:buffer(b:fugitive_blamed_bufnr).path()
  endif
  let args = b:fugitive_blame_arguments
  let offset = line('.') - line('w0')
  let bufnr = bufnr('%')
  let winnr = bufwinnr(b:fugitive_blamed_bufnr)
  if winnr > 0
    exe winnr.'wincmd w'
  endif
  execute s:Edit('edit', 0, commit.a:suffix.':'.path)
  execute lnum
  if winnr > 0
    exe bufnr.'bdelete'
  endif
  execute 'Gblame '.args
  execute lnum
  let delta = line('.') - line('w0') - offset
  if delta > 0
    execute 'normal! '.delta."\<C-E>"
  elseif delta < 0
    execute 'normal! '.(-delta)."\<C-Y>"
  endif
  syncbind
  return ''
endfunction

function! s:BlameSyntax() abort
  let b:current_syntax = 'fugitiveblame'
  syn match FugitiveblameBoundary "^\^"
  syn match FugitiveblameBlank                      "^\s\+\s\@=" nextgroup=FugitiveblameAnnotation,fugitiveblameOriginalFile,FugitiveblameOriginalLineNumber skipwhite
  syn match FugitiveblameHash       "\%(^\^\=\)\@<=\x\{7,40\}\>" nextgroup=FugitiveblameAnnotation,FugitiveblameOriginalLineNumber,fugitiveblameOriginalFile skipwhite
  syn match FugitiveblameUncommitted "\%(^\^\=\)\@<=0\{7,40\}\>" nextgroup=FugitiveblameAnnotation,FugitiveblameOriginalLineNumber,fugitiveblameOriginalFile skipwhite
  syn region FugitiveblameAnnotation matchgroup=FugitiveblameDelimiter start="(" end="\%( \d\+\)\@<=)" contained keepend oneline
  syn match FugitiveblameTime "[0-9:/+-][0-9:/+ -]*[0-9:/+-]\%( \+\d\+)\)\@=" contained containedin=FugitiveblameAnnotation
  syn match FugitiveblameLineNumber         " \@<=\d\+)\@=" contained containedin=FugitiveblameAnnotation
  syn match FugitiveblameOriginalFile       " \%(\f\+\D\@<=\|\D\@=\f\+\)\%(\%(\s\+\d\+\)\=\s\%((\|\s*\d\+)\)\)\@=" contained nextgroup=FugitiveblameOriginalLineNumber,FugitiveblameAnnotation skipwhite
  syn match FugitiveblameOriginalLineNumber " \@<=\d\+\%(\s(\)\@=" contained nextgroup=FugitiveblameAnnotation skipwhite
  syn match FugitiveblameOriginalLineNumber " \@<=\d\+\%(\s\+\d\+)\)\@=" contained nextgroup=FugitiveblameShort skipwhite
  syn match FugitiveblameShort              "\d\+)" contained contains=FugitiveblameLineNumber
  syn match FugitiveblameNotCommittedYet "(\@<=Not Committed Yet\>" contained containedin=FugitiveblameAnnotation
  hi def link FugitiveblameBoundary           Keyword
  hi def link FugitiveblameHash               Identifier
  hi def link FugitiveblameUncommitted        Function
  hi def link FugitiveblameTime               PreProc
  hi def link FugitiveblameLineNumber         Number
  hi def link FugitiveblameOriginalFile       String
  hi def link FugitiveblameOriginalLineNumber Float
  hi def link FugitiveblameShort              FugitiveblameDelimiter
  hi def link FugitiveblameDelimiter          Delimiter
  hi def link FugitiveblameNotCommittedYet    Comment
endfunction

" }}}1
" Gbrowse {{{1

call s:command("-bar -bang -count=0 -nargs=? -complete=customlist,s:EditComplete Gbrowse :execute s:Browse(<bang>0,<line1>,<count>,<f-args>)")

function! s:Browse(bang,line1,count,...) abort
  try
    let rev = a:0 ? substitute(a:1,'@[[:alnum:]_-]*\%(://.\{-\}\)\=$','','') : ''
    if rev ==# ''
      let expanded = s:buffer().rev()
    elseif rev ==# ':'
      let expanded = s:buffer().path('/')
    else
      let expanded = s:buffer().expand(rev)
    endif
    let full = s:repo().translate(expanded)
    let commit = ''
    if full =~# '^fugitive://'
      let commit = matchstr(full,'://.*//\zs\w\+')
      let path = matchstr(full,'://.*//\w\+\zs/.*')
      if commit =~ '..'
        let type = s:repo().git_chomp('cat-file','-t',commit.s:sub(path,'^/',':'))
      else
        let type = 'blob'
      endif
      let path = path[1:-1]
    elseif s:repo().bare()
      let path = '.git/' . full[strlen(s:repo().dir())+1:-1]
      let type = ''
    else
      let path = full[strlen(s:repo().tree())+1:-1]
      if path =~# '^\.git/'
        let type = ''
      elseif isdirectory(full)
        let type = 'tree'
      else
        let type = 'blob'
      endif
    endif
    if path =~# '^\.git/.*HEAD' && filereadable(s:repo().dir(path[5:-1]))
      let body = readfile(s:repo().dir(path[5:-1]))[0]
      if body =~# '^\x\{40\}$'
        let commit = body
        let type = 'commit'
        let path = ''
      elseif body =~# '^ref: refs/'
        let path = '.git/' . matchstr(body,'ref: \zs.*')
      endif
    endif

    if a:0 && a:1 =~# '@[[:alnum:]_-]*\%(://.\{-\}\)\=$'
      let remote = matchstr(a:1,'@\zs[[:alnum:]_-]\+\%(://.\{-\}\)\=$')
    elseif path =~# '^\.git/refs/remotes/.'
      let remote = matchstr(path,'^\.git/refs/remotes/\zs[^/]\+')
    else
      let remote = 'origin'
      let branch = matchstr(rev,'^[[:alnum:]/._-]\+\ze[:^~@]')
      if branch ==# '' && path =~# '^\.git/refs/\w\+/'
        let branch = s:sub(path,'^\.git/refs/\w+/','')
      endif
      if filereadable(s:repo().dir('refs/remotes/'.branch))
        let remote = matchstr(branch,'[^/]\+')
        let rev = rev[strlen(remote)+1:-1]
      else
        if branch ==# ''
          let branch = matchstr(s:repo().head_ref(),'\<refs/heads/\zs.*')
        endif
        if branch != ''
          let remote = s:repo().git_chomp('config','branch.'.branch.'.remote')
          if remote =~# '^\.\=$'
            let remote = 'origin'
          elseif rev[0:strlen(branch)-1] ==# branch && rev[strlen(branch)] =~# '[:^~@]'
            let rev = s:repo().git_chomp('config','branch.'.branch.'.merge')[11:-1] . rev[strlen(branch):-1]
          endif
        endif
      endif
    endif

    let raw = s:repo().git_chomp('config','remote.'.remote.'.url')
    if raw ==# ''
      let raw = remote
    endif

    let url = s:github_url(s:repo(),raw,rev,commit,path,type,a:line1,a:count)
    if url == ''
      let url = s:instaweb_url(s:repo(),rev,commit,path,type,a:count ? a:line1 : 0)
    endif

    if url == ''
      call s:throw("Instaweb failed to start and '".remote."' is not a GitHub remote")
    endif

    if a:bang
      let @* = url
      return 'echomsg '.string(url)
    else
      return 'echomsg '.string(url).'|call fugitive#buffer().repo().git_chomp("web--browse",'.string(url).')'
    endif
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

function! s:github_url(repo,url,rev,commit,path,type,line1,line2) abort
  let path = a:path
  let repo_path = matchstr(a:url,'^\%(https\=://\|git://\|git@\)github\.com[/:]\zs.\{-\}\ze\%(\.git\)\=$')
  if repo_path ==# ''
    return ''
  endif
  let root = 'https://github.com/' . repo_path
  if path =~# '^\.git/refs/heads/'
    let branch = a:repo.git_chomp('config','branch.'.path[16:-1].'.merge')[11:-1]
    if branch ==# ''
      return root . '/commits/' . path[16:-1]
    else
      return root . '/commits/' . branch
    endif
  elseif path =~# '^\.git/refs/.'
    return root . '/commits/' . matchstr(path,'[^/]\+$')
  elseif path =~# '.git/\%(config$\|hooks\>\)'
    return root . '/admin'
  elseif path =~# '^\.git\>'
    return root
  endif
  if a:rev =~# '^[[:alnum:]._-]\+:'
    let commit = matchstr(a:rev,'^[^:]*')
  elseif a:commit =~# '^\d\=$'
    let local = matchstr(a:repo.head_ref(),'\<refs/heads/\zs.*')
    let commit = a:repo.git_chomp('config','branch.'.local.'.merge')[11:-1]
    if commit ==# ''
      let commit = local
    endif
  else
    let commit = a:commit
  endif
  if a:type == 'tree'
    let url = s:sub(root . '/tree/' . commit . '/' . path,'/$','')
  elseif a:type == 'blob'
    let url = root . '/blob/' . commit . '/' . path
    if a:line2 && a:line1 == a:line2
      let url .= '#L' . a:line1
    elseif a:line2
      let url .= '#L' . a:line1 . '-' . a:line2
    endif
  elseif a:type == 'tag'
    let commit = matchstr(getline(3),'^tag \zs.*')
    let url = root . '/tree/' . commit
  else
    let url = root . '/commit/' . commit
  endif
  return url
endfunction

function! s:instaweb_url(repo,rev,commit,path,type,...) abort
  let output = a:repo.git_chomp('instaweb','-b','unknown')
  if output =~# 'http://'
    let root = matchstr(output,'http://.*').'/?p='.fnamemodify(a:repo.dir(),':t')
  else
    return ''
  endif
  if a:path =~# '^\.git/refs/.'
    return root . ';a=shortlog;h=' . matchstr(a:path,'^\.git/\zs.*')
  elseif a:path =~# '^\.git\>'
    return root
  endif
  let url = root
  if a:commit =~# '^\x\{40\}$'
    if a:type ==# 'commit'
      let url .= ';a=commit'
    endif
    let url .= ';h=' . a:repo.rev_parse(a:commit . (a:path == '' ? '' : ':' . a:path))
  else
    if a:type ==# 'blob'
      let tmp = tempname()
      silent execute 'write !'.a:repo.git_command('hash-object','-w','--stdin').' > '.tmp
      let url .= ';h=' . readfile(tmp)[0]
    else
      try
        let url .= ';h=' . a:repo.rev_parse((a:commit == '' ? 'HEAD' : ':' . a:commit) . ':' . a:path)
      catch /^fugitive:/
        call s:throw('fugitive: cannot browse uncommitted file')
      endtry
    endif
    let root .= ';hb=' . matchstr(a:repo.head_ref(),'[^ ]\+$')
  endif
  if a:path !=# ''
    let url .= ';f=' . a:path
  endif
  if a:0 && a:1
    let url .= '#l' . a:1
  endif
  return url
endfunction

" }}}1
" File access {{{1

function! s:ReplaceCmd(cmd,...) abort
  let fn = bufname('')
  let tmp = tempname()
  let prefix = ''
  try
    if a:0 && a:1 != ''
      if &shell =~# 'cmd'
        let old_index = $GIT_INDEX_FILE
        let $GIT_INDEX_FILE = a:1
      else
        let prefix = 'env GIT_INDEX_FILE='.s:shellesc(a:1).' '
      endif
    endif
    if &shell =~# 'cmd'
      call system('cmd /c "'.prefix.a:cmd.' > '.tmp.'"')
    else
      call system(' ('.prefix.a:cmd.' > '.tmp.') ')
    endif
  finally
    if exists('old_index')
      let $GIT_INDEX_FILE = old_index
    endif
  endtry
  silent exe 'keepalt file '.tmp
  silent edit!
  silent exe 'keepalt file '.s:fnameescape(fn)
  call delete(tmp)
  if bufname('$') == tmp
    silent execute 'bwipeout '.bufnr('$')
  endif
  silent exe 'doau BufReadPost '.s:fnameescape(fn)
endfunction

function! s:BufReadIndex()
  if !exists('b:fugitive_display_format')
    let b:fugitive_display_format = filereadable(expand('%').'.lock')
  endif
  let b:fugitive_display_format = b:fugitive_display_format % 2
  let b:fugitive_type = 'index'
  try
    let b:git_dir = s:repo().dir()
    setlocal noro ma
    if fnamemodify($GIT_INDEX_FILE !=# '' ? $GIT_INDEX_FILE : b:git_dir . '/index', ':p') ==# expand('%:p')
      let index = ''
    else
      let index = expand('%:p')
    endif
    if b:fugitive_display_format
      call s:ReplaceCmd(s:repo().git_command('ls-files','--stage'),index)
      set ft=git nospell
    else
      let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
      let dir = getcwd()
      try
        execute cd.'`=s:repo().tree()`'
        call s:ReplaceCmd(s:repo().git_command('status'),index)
      finally
        execute cd.'`=dir`'
      endtry
      set ft=gitcommit
    endif
    setlocal ro noma nomod nomodeline noswapfile bufhidden=wipe
    call s:JumpInit()
    nunmap   <buffer>          P
    nunmap   <buffer>          ~
    nnoremap <buffer> <silent> <C-N> :call search('^#\t.*','W')<Bar>.<CR>
    nnoremap <buffer> <silent> <C-P> :call search('^#\t.*','Wbe')<Bar>.<CR>
    nnoremap <buffer> <silent> - :<C-U>execute <SID>StageToggle(line('.'),line('.')+v:count1-1)<CR>
    xnoremap <buffer> <silent> - :<C-U>execute <SID>StageToggle(line("'<"),line("'>"))<CR>
    nnoremap <buffer> <silent> a :<C-U>let b:fugitive_display_format += 1<Bar>exe <SID>BufReadIndex()<CR>
    nnoremap <buffer> <silent> i :<C-U>let b:fugitive_display_format -= 1<Bar>exe <SID>BufReadIndex()<CR>
    nnoremap <buffer> <silent> C :<C-U>Gcommit<CR>
    nnoremap <buffer> <silent> cA :<C-U>Gcommit --amend --reuse-message=HEAD<CR>
    nnoremap <buffer> <silent> ca :<C-U>Gcommit --amend<CR>
    nnoremap <buffer> <silent> cc :<C-U>Gcommit<CR>
    nnoremap <buffer> <silent> D :<C-U>execute <SID>StageDiff('Gvdiff')<CR>
    nnoremap <buffer> <silent> dd :<C-U>execute <SID>StageDiff('Gvdiff')<CR>
    nnoremap <buffer> <silent> dh :<C-U>execute <SID>StageDiff('Gsdiff')<CR>
    nnoremap <buffer> <silent> ds :<C-U>execute <SID>StageDiff('Gsdiff')<CR>
    nnoremap <buffer> <silent> dp :<C-U>execute <SID>StageDiffEdit()<CR>
    nnoremap <buffer> <silent> dv :<C-U>execute <SID>StageDiff('Gvdiff')<CR>
    nnoremap <buffer> <silent> p :<C-U>execute <SID>StagePatch(line('.'),line('.')+v:count1-1)<CR>
    xnoremap <buffer> <silent> p :<C-U>execute <SID>StagePatch(line("'<"),line("'>"))<CR>
    nnoremap <buffer> <silent> q :<C-U>if bufnr('$') == 1<Bar>quit<Bar>else<Bar>bdelete<Bar>endif<CR>
    nnoremap <buffer> <silent> R :<C-U>edit<CR>
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

function! s:FileRead()
  try
    let repo = s:repo(s:ExtractGitDir(expand('<amatch>')))
    let path = s:sub(s:sub(matchstr(expand('<amatch>'),'fugitive://.\{-\}//\zs.*'),'/',':'),'^\d:',':&')
    let hash = repo.rev_parse(path)
    if path =~ '^:'
      let type = 'blob'
    else
      let type = repo.git_chomp('cat-file','-t',hash)
    endif
    " TODO: use count, if possible
    return "read !".escape(repo.git_command('cat-file',type,hash),'%#\')
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

function! s:BufReadIndexFile()
  try
    let b:fugitive_type = 'blob'
    let b:git_dir = s:repo().dir()
    call s:ReplaceCmd(s:repo().git_command('cat-file','blob',s:buffer().sha1()))
    if &bufhidden ==# ''
      setlocal bufhidden=delete
    endif
    return ''
  catch /^fugitive: rev-parse/
    silent exe 'doau BufNewFile '.s:fnameescape(bufname(''))
    return ''
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

function! s:BufWriteIndexFile()
  let tmp = tempname()
  try
    let path = matchstr(expand('<amatch>'),'//\d/\zs.*')
    let stage = matchstr(expand('<amatch>'),'//\zs\d')
    silent execute 'write !'.s:repo().git_command('hash-object','-w','--stdin').' > '.tmp
    let sha1 = readfile(tmp)[0]
    let old_mode = matchstr(s:repo().git_chomp('ls-files','--stage',path),'^\d\+')
    if old_mode == ''
      let old_mode = executable(s:repo().tree(path)) ? '100755' : '100644'
    endif
    let info = old_mode.' '.sha1.' '.stage."\t".path
    call writefile([info],tmp)
    if has('win32')
      let error = system('type '.tmp.'|'.s:repo().git_command('update-index','--index-info'))
    else
      let error = system(s:repo().git_command('update-index','--index-info').' < '.tmp)
    endif
    if v:shell_error == 0
      setlocal nomodified
      silent execute 'doautocmd BufWritePost '.s:fnameescape(expand('%:p'))
      call fugitive#reload_status()
      return ''
    else
      return 'echoerr '.string('fugitive: '.error)
    endif
  finally
    call delete(tmp)
  endtry
endfunction

function! s:BufReadObject()
  try
    setlocal noro ma
    let b:git_dir = s:repo().dir()
    let hash = s:buffer().sha1()
    if !exists("b:fugitive_type")
      let b:fugitive_type = s:repo().git_chomp('cat-file','-t',hash)
    endif
    if b:fugitive_type !~# '^\%(tag\|commit\|tree\|blob\)$'
      return "echoerr 'fugitive: unrecognized git type'"
    endif
    let firstline = getline('.')
    if !exists('b:fugitive_display_format') && b:fugitive_type != 'blob'
      let b:fugitive_display_format = +getbufvar('#','fugitive_display_format')
    endif

    let pos = getpos('.')
    silent %delete
    setlocal endofline

    if b:fugitive_type == 'tree'
      let b:fugitive_display_format = b:fugitive_display_format % 2
      if b:fugitive_display_format
        call s:ReplaceCmd(s:repo().git_command('ls-tree',hash))
      else
        call s:ReplaceCmd(s:repo().git_command('show','--no-color',hash))
      endif
    elseif b:fugitive_type == 'tag'
      let b:fugitive_display_format = b:fugitive_display_format % 2
      if b:fugitive_display_format
        call s:ReplaceCmd(s:repo().git_command('cat-file',b:fugitive_type,hash))
      else
        call s:ReplaceCmd(s:repo().git_command('cat-file','-p',hash))
      endif
    elseif b:fugitive_type == 'commit'
      let b:fugitive_display_format = b:fugitive_display_format % 2
      if b:fugitive_display_format
        call s:ReplaceCmd(s:repo().git_command('cat-file',b:fugitive_type,hash))
      else
        call s:ReplaceCmd(s:repo().git_command('show','--no-color','--pretty=format:tree %T%nparent %P%nauthor %an <%ae> %ad%ncommitter %cn <%ce> %cd%nencoding %e%n%n%s%n%n%b',hash))
        call search('^parent ')
        if getline('.') ==# 'parent '
          silent delete_
        else
          silent s/\%(^parent\)\@<! /\rparent /ge
        endif
        if search('^encoding \%(<unknown>\)\=$','W',line('.')+3)
          silent delete_
        end
        1
      endif
    elseif b:fugitive_type ==# 'blob'
      call s:ReplaceCmd(s:repo().git_command('cat-file',b:fugitive_type,hash))
    endif
    call setpos('.',pos)
    setlocal ro noma nomod nomodeline
    if &bufhidden ==# ''
      setlocal bufhidden=delete
    endif
    if b:fugitive_type !=# 'blob'
      set filetype=git
      nnoremap <buffer> <silent> a :<C-U>let b:fugitive_display_format += v:count1<Bar>exe <SID>BufReadObject()<CR>
      nnoremap <buffer> <silent> i :<C-U>let b:fugitive_display_format -= v:count1<Bar>exe <SID>BufReadObject()<CR>
    else
      call s:JumpInit()
    endif

    return ''
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

augroup fugitive_files
  autocmd!
  autocmd BufReadCmd  *.git/index                      exe s:BufReadIndex()
  autocmd BufReadCmd  *.git/*index*.lock               exe s:BufReadIndex()
  autocmd FileReadCmd fugitive://**//[0-3]/**          exe s:FileRead()
  autocmd BufReadCmd  fugitive://**//[0-3]/**          exe s:BufReadIndexFile()
  autocmd BufWriteCmd fugitive://**//[0-3]/**          exe s:BufWriteIndexFile()
  autocmd BufReadCmd  fugitive://**//[0-9a-f][0-9a-f]* exe s:BufReadObject()
  autocmd FileReadCmd fugitive://**//[0-9a-f][0-9a-f]* exe s:FileRead()
  autocmd FileType git       call s:JumpInit()
augroup END

" }}}1
" Temp files {{{1

if !exists('s:temp_files')
  let s:temp_files = {}
endif

augroup fugitive_temp
  autocmd!
  autocmd BufNewFile,BufReadPost *
        \ if has_key(s:temp_files,expand('<amatch>:p')) |
        \   let b:git_dir = s:temp_files[expand('<amatch>:p')] |
        \   let b:git_type = 'temp' |
        \   call s:Detect(expand('<amatch>:p')) |
        \   setlocal bufhidden=delete |
        \   nnoremap <buffer> <silent> q    :<C-U>bdelete<CR>|
        \ endif
augroup END

" }}}1
" Go to file {{{1

function! s:JumpInit() abort
  nnoremap <buffer> <silent> <CR>    :<C-U>exe <SID>GF("edit")<CR>
  if !&modifiable
    nnoremap <buffer> <silent> o     :<C-U>exe <SID>GF("split")<CR>
    nnoremap <buffer> <silent> O     :<C-U>exe <SID>GF("tabedit")<CR>
    nnoremap <buffer> <silent> P     :<C-U>exe <SID>Edit('edit',0,<SID>buffer().commit().'^'.v:count1.<SID>buffer().path(':'))<CR>
    nnoremap <buffer> <silent> ~     :<C-U>exe <SID>Edit('edit',0,<SID>buffer().commit().'~'.v:count1.<SID>buffer().path(':'))<CR>
    nnoremap <buffer> <silent> C     :<C-U>exe <SID>Edit('edit',0,<SID>buffer().containing_commit())<CR>
    nnoremap <buffer> <silent> cc    :<C-U>exe <SID>Edit('edit',0,<SID>buffer().containing_commit())<CR>
    nnoremap <buffer> <silent> co    :<C-U>exe <SID>Edit('split',0,<SID>buffer().containing_commit())<CR>
    nnoremap <buffer> <silent> cO    :<C-U>exe <SID>Edit('tabedit',0,<SID>buffer().containing_commit())<CR>
    nnoremap <buffer> <silent> cp    :<C-U>exe <SID>Edit('pedit',0,<SID>buffer().containing_commit())<CR>
  endif
endfunction

function! s:GF(mode) abort
  try
    let buffer = s:buffer()
    let myhash = buffer.sha1()
    if myhash ==# '' && getline(1) =~# '^\%(commit\|tag\) \w'
      let myhash = matchstr(getline(1),'^\w\+ \zs\S\+')
    endif

    if buffer.type('tree')
      let showtree = (getline(1) =~# '^tree ' && getline(2) == "")
      if showtree && line('.') == 1
        return ""
      elseif showtree && line('.') > 2
        return s:Edit(a:mode,0,buffer.commit().':'.s:buffer().path().(buffer.path() =~# '^$\|/$' ? '' : '/').s:sub(getline('.'),'/$',''))
      elseif getline('.') =~# '^\d\{6\} \l\{3,8\} \x\{40\}\t'
        return s:Edit(a:mode,0,buffer.commit().':'.s:buffer().path().(buffer.path() =~# '^$\|/$' ? '' : '/').s:sub(matchstr(getline('.'),'\t\zs.*'),'/$',''))
      endif

    elseif buffer.type('blob')
      let ref = expand("<cfile>")
      try
        let sha1 = buffer.repo().rev_parse(ref)
      catch /^fugitive:/
      endtry
      if exists('sha1')
        return s:Edit(a:mode,0,ref)
      endif

    else

      " Index
      if getline('.') =~# '^\d\{6\} \x\{40\} \d\t'
        let ref = matchstr(getline('.'),'\x\{40\}')
        let file = ':'.s:sub(matchstr(getline('.'),'\d\t.*'),'\t',':')
        return s:Edit(a:mode,0,file)

      elseif getline('.') =~# '^#\trenamed:.* -> '
        let file = '/'.matchstr(getline('.'),' -> \zs.*')
        return s:Edit(a:mode,0,file)
      elseif getline('.') =~# '^#\t[[:alpha:] ]\+: *.'
        let file = '/'.matchstr(getline('.'),': *\zs.\{-\}\ze\%( (new commits)\)\=$')
        return s:Edit(a:mode,0,file)
      elseif getline('.') =~# '^#\t.'
        let file = '/'.matchstr(getline('.'),'#\t\zs.*')
        return s:Edit(a:mode,0,file)
      elseif getline('.') =~# ': needs merge$'
        let file = '/'.matchstr(getline('.'),'.*\ze: needs merge$')
        return s:Edit(a:mode,0,file).'|Gdiff'

      elseif getline('.') ==# '# Not currently on any branch.'
        return s:Edit(a:mode,0,'HEAD')
      elseif getline('.') =~# '^# On branch '
        let file = 'refs/heads/'.getline('.')[12:]
        return s:Edit(a:mode,0,file)
      elseif getline('.') =~# "^# Your branch .*'"
        let file = matchstr(getline('.'),"'\\zs\\S\\+\\ze'")
        return s:Edit(a:mode,0,file)
      endif

      let showtree = (getline(1) =~# '^tree ' && getline(2) == "")

      if getline('.') =~# '^ref: '
        let ref = strpart(getline('.'),5)

      elseif getline('.') =~# '^commit \x\{40\}\>'
        let ref = matchstr(getline('.'),'\x\{40\}')
        return s:Edit(a:mode,0,ref)

      elseif getline('.') =~# '^parent \x\{40\}\>'
        let ref = matchstr(getline('.'),'\x\{40\}')
        let line = line('.')
        let parent = 0
        while getline(line) =~# '^parent '
          let parent += 1
          let line -= 1
        endwhile
        return s:Edit(a:mode,0,ref)

      elseif getline('.') =~ '^tree \x\{40\}$'
        let ref = matchstr(getline('.'),'\x\{40\}')
        if s:repo().rev_parse(myhash.':') == ref
          let ref = myhash.':'
        endif
        return s:Edit(a:mode,0,ref)

      elseif getline('.') =~# '^object \x\{40\}$' && getline(line('.')+1) =~ '^type \%(commit\|tree\|blob\)$'
        let ref = matchstr(getline('.'),'\x\{40\}')
        let type = matchstr(getline(line('.')+1),'type \zs.*')

      elseif getline('.') =~# '^\l\{3,8\} '.myhash.'$'
        return ''

      elseif getline('.') =~# '^\l\{3,8\} \x\{40\}\>'
        let ref = matchstr(getline('.'),'\x\{40\}')
        echoerr "warning: unknown context ".matchstr(getline('.'),'^\l*')

      elseif getline('.') =~# '^[+-]\{3\} [ab/]'
        let ref = getline('.')[4:]

      elseif getline('.') =~# '^[+-]' && search('^@@ -\d\+,\d\+ +\d\+,','bnW')
        let type = getline('.')[0]
        let lnum = line('.') - 1
        let offset = -1
        while getline(lnum) !~# '^@@ -\d\+,\d\+ +\d\+,'
          if getline(lnum) =~# '^[ '.type.']'
            let offset += 1
          endif
          let lnum -= 1
        endwhile
        let offset += matchstr(getline(lnum), type.'\zs\d\+')
        let ref = getline(search('^'.type.'\{3\} [ab]/','bnW'))[4:-1]
        let dcmd = '+'.offset.'|foldopen'
        let dref = ''

      elseif getline('.') =~# '^rename from '
        let ref = 'a/'.getline('.')[12:]
      elseif getline('.') =~# '^rename to '
        let ref = 'b/'.getline('.')[10:]

      elseif getline('.') =~# '^diff --git \%(a/.*\|/dev/null\) \%(b/.*\|/dev/null\)'
        let dref = matchstr(getline('.'),'\Cdiff --git \zs\%(a/.*\|/dev/null\)\ze \%(b/.*\|/dev/null\)')
        let ref = matchstr(getline('.'),'\Cdiff --git \%(a/.*\|/dev/null\) \zs\%(b/.*\|/dev/null\)')
        let dcmd = 'Gdiff'

      elseif getline('.') =~# '^index ' && getline(line('.')-1) =~# '^diff --git \%(a/.*\|/dev/null\) \%(b/.*\|/dev/null\)'
        let line = getline(line('.')-1)
        let dref = matchstr(line,'\Cdiff --git \zs\%(a/.*\|/dev/null\)\ze \%(b/.*\|/dev/null\)')
        let ref = matchstr(line,'\Cdiff --git \%(a/.*\|/dev/null\) \zs\%(b/.*\|/dev/null\)')
        let dcmd = 'Gdiff!'

      elseif line('$') == 1 && getline('.') =~ '^\x\{40\}$'
        let ref = getline('.')
      else
        let ref = ''
      endif

      if myhash ==# ''
        let ref = s:sub(ref,'^a/','HEAD:')
        let ref = s:sub(ref,'^b/',':0:')
        if exists('dref')
          let dref = s:sub(dref,'^a/','HEAD:')
        endif
      else
        let ref = s:sub(ref,'^a/',myhash.'^:')
        let ref = s:sub(ref,'^b/',myhash.':')
        if exists('dref')
          let dref = s:sub(dref,'^a/',myhash.'^:')
        endif
      endif

      if ref ==# '/dev/null'
        " Empty blob
        let ref = 'e69de29bb2d1d6434b8b29ae775ad8c2e48c5391'
      endif

      if exists('dref')
        return s:Edit(a:mode,0,ref) . '|'.dcmd.' '.s:fnameescape(dref)
      elseif ref != ""
        return s:Edit(a:mode,0,ref)
      endif

    endif
    return ''
  catch /^fugitive:/
    return 'echoerr v:errmsg'
  endtry
endfunction

" }}}1
" Statusline {{{1

function! s:repo_head_ref() dict abort
  return readfile(s:repo().dir('HEAD'))[0]
endfunction

call s:add_methods('repo',['head_ref'])

function! fugitive#statusline(...)
  if !exists('b:git_dir')
    return ''
  endif
  let status = ''
  if s:buffer().commit() != ''
    let status .= ':' . s:buffer().commit()[0:7]
  endif
  let head = s:repo().head_ref()
  if head =~# '^ref: '
    let status .= s:sub(head,'^ref: %(refs/%(heads/|remotes/|tags/)=)=','(').')'
  elseif head =~# '^\x\{40\}$'
    let status .= '('.head[0:7].')'
  endif
  if &statusline =~# '%[MRHWY]' && &statusline !~# '%[mrhwy]'
    return ',GIT'.status
  else
    return '[Git'.status.']'
  endif
endfunction

" }}}1

" vim:set ft=vim ts=8 sw=2 sts=2:
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               .vim/plugin/greplace.vim                                                                            0000700 0001751 0001751 00000020633 12126773534 014377  0                                                                                                    ustar   x0199365                        x0199365                                                                                                                                                                                                               " File: greplace.vim
" Script to search and replace pattern across multiple files
" Author: Yegappan Lakshmanan (yegappan AT yahoo DOT com)
" Version: 1.0 Beta1
" Last Modified: March 3, 2007
"
if exists("loaded_greplace")
    finish
endif
let loaded_greplace = 1

" Requires Vim 7.0 and above
if v:version < 700
    finish
endif

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

if &isfname =~ '['
    let s:gRepl_bufname = '[Global\ Replace]'
else
    let s:gRepl_bufname = '\[Global\ Replace\]'
endif

" Character to use to quote patterns
if !exists("Greplace_Shell_Quote_Char")
    if has("win32") || has("win16") || has("win95")
        let Greplace_Shell_Quote_Char = ''
    else
        let Greplace_Shell_Quote_Char = "'"
    endif
endif

let s:save_qf_list = {}

function! s:warn_msg(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

highlight GReplaceText term=reverse cterm=reverse gui=reverse

function! s:gReplace()
    if empty(s:save_qf_list)
        return
    endif

    let change_all = v:cmdbang

    let changeset = {}

    " Parse the replace buffer contents and get a List of changed lines
    let lines = getbufline('%', 1, '$')
    for l in lines
        if l !~ '[^:]\+:\d\+:.*'
            continue
        endif

        let match_l = matchlist(l, '\([^:]\+\):\(\d\+\):\(.*\)')
        let fname = match_l[1]
        let lnum = match_l[2]
        let text = match_l[3]

        let key = fname . ':' . lnum
        if s:save_qf_list[key].text == text
            " This line is not changed
            continue
        endif

        let fname = s:save_qf_list[key].fname
        if !has_key(changeset, fname)
            let changeset[fname] = {}
        endif

        let changeset[fname][lnum] = text
    endfor

    if empty(changeset)
        " The replace buffer is not changed by the user
        call s:warn_msg('Error: No changes in the replace buffer')
        return
    endif

    " Make the changes made by the user to the buffers
    for f in keys(changeset)
        let f_l = changeset[f]
        if !filereadable(f)
            continue
        endif
        silent! exe 'hide edit ' . f

        let change_buf_all = 0   " Accept all the changes in this buffer

        for lnum in keys(f_l)
            exe lnum

            let cur_ltext = getline(lnum)
            let new_ltext = f_l[lnum]

            let s_idx =0
            while cur_ltext[s_idx] == new_ltext[s_idx]
                let s_idx += 1
            endwhile

            let e_idx1 = strlen(cur_ltext) - 1
            let e_idx2 = strlen(new_ltext) - 1
            while e_idx1 >= 0 && cur_ltext[e_idx1] == new_ltext[e_idx2]
                let e_idx1 -= 1
                let e_idx2 -= 1
            endwhile

            let e_idx1 += 2

            if (s_idx + 1) == e_idx1 
                " If there is nothing to highlight, then highlight the
                " last character
                let e_idx1 += 1
            endif

            let hl_pat = '/\%'.lnum.'l\%>'.s_idx.'v.*\%<'.e_idx1.'v/'
            exe '2match GReplaceText ' . hl_pat
            redraw!

            try
                let change_line = 0

                if !change_all && !change_buf_all
                    let new_text_frag = strpart(new_ltext, s_idx,
                                \ e_idx2 - s_idx + 1)

                    echo "Replace with '" . new_text_frag . "' (y/n/a/b/q)?"
                    let ans = 'x'
                    while ans !~? '[ynab]'
                        let ans = nr2char(getchar())
                        if ans == 'q' || ans == "\<Esc>"      " Quit
                            return
                        endif
                    endwhile
                    if ans == 'a'       " Accept all
                        let change_all = 1
                    endif
                    if ans == 'b'       " Accept changes in the current buffer
                        let change_buf_all = 1
                    endif
                    if ans == 'y'       " Yes
                        let change_line = 1
                    endif
                endif

                if change_all || change_buf_all || change_line
                    call setline(lnum, f_l[lnum])
                endif
            finally
                2match none
            endtry
        endfor
    endfor
endfunction

function! s:gReplace_show_matches()
    let qf = getqflist()
    if empty(qf)
        call s:warn_msg('Error: Quickfix list is empty')
        return
    endif

    let new_qf = {}

    " Populate the buffer with the current quickfix list
    let lines = []
    for l in qf
        if l.valid && l.lnum > 0 && l.bufnr > 0
            let fname = fnamemodify(bufname(l.bufnr), ':.')
            let buf_text = fname . ':' . l.lnum . ':' . l.text
            let k = fname . ':' . l.lnum
            let new_qf[k] = {}
            let new_qf[k].fname = fnamemodify(bufname(l.bufnr), ':p')
            let new_qf[k].text = l.text
        else
            let buf_text = l.text
        endif

        call add(lines, buf_text)
    endfor

    if empty(lines)
        " No valid matching lines
        return
    endif

    let w = bufwinnr(s:gRepl_bufname)
    if w == -1
        " Create a new window
        silent! exe 'new ' . s:gRepl_bufname
    else
        exe w . 'wincmd w'

        " Discard the contents of the buffer
        %d _
    endif

    call append(0, '#')
    call append(1, '# Modify the contents of this buffer and then')
    call append(2, '# use the ":Greplace" command to merge the changes.')
    call append(3, '#')
    call append(4, lines)

    call cursor(5, 1)
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nomodified

    command! -buffer -nargs=0 -bang Greplace call s:gReplace()

    let s:save_qf_list = new_qf
endfunction

" gSearch
" Search for a pattern in a group of files using ':grep'
function! s:gSearch(type, ...)
    let grep_opt  = ''
    let pattern   = ''
    let filenames = ''

    " Parse the arguments
    " grep command-line flags are specified using the "-flag" format
    " the next argument is assumed to be the pattern
    " and the next arguments are assumed to be filenames or file patterns
    let argcnt = 1
    while argcnt <= a:0
        if &grepprg =~ 'findstr' && a:{argcnt} =~ '^/'
            let grep_opt = grep_opt . ' ' . a:{argcnt}
        elseif a:{argcnt} =~ '^-'
            let grep_opt = grep_opt . ' ' . a:{argcnt}
        elseif pattern == ''
            let pattern = a:{argcnt}
        else
            let filenames = filenames . ' ' . a:{argcnt}
        endif
        let argcnt += 1
    endwhile

    " If search pattern is not specified on command-line, ask for it
    if pattern == ''
        let pattern = input('Search pattern: ', expand('<cword>'))
        if pattern == ''
            return
        endif

        " Quote the supplied pattern
        let pattern = g:Greplace_Shell_Quote_Char . pattern .
                    \ g:Greplace_Shell_Quote_Char
    endif

    if a:type == 'grep'
        if filenames == ''
            let filenames = input('Search in files: ', '*', 'file')
        endif
    elseif a:type == 'args'
        " Search in all the filenames in the argument list
        let arg_cnt = argc()

        if arg_cnt == 0
            call s:warn_msg('Error: Argument list is empty')
            return
        endif

        let filenames = ''
        for i in range(0, arg_cnt - 1)
            let filenames .= ' ' . argv(i)
        endfor
    else
        " Get a list of all the buffer names
        let filenames = ''
        for i in range(1, bufnr('$'))
            let bname = bufname(i)
            if bufexists(i) && buflisted(i) && filereadable(bname) &&
                        \ getbufvar(i, '&buftype') == ''
                let filenames .= ' ' . bufname(i)
            endif
        endfor
    endif

    if filenames == ''
        call s:warn_msg('Error: No valid file names')
        return
    endif

    " Use ! after grep, so that Vim doesn't automatically jump to the
    " first match
    let grep_cmd = 'grep! ' . grep_opt . ' ' . pattern . ' ' . filenames

    " Run the grep and get the matches
    exe grep_cmd

    call s:gReplace_show_matches()
endfunction

command! -nargs=0 Gqfopen call s:gReplace_show_matches()
command! -nargs=* -complete=file Gsearch call s:gSearch('grep', <f-args>)
command! -nargs=* Gargsearch call s:gSearch('args', <f-args>)
command! -nargs=* Gbuffersearch call s:gSearch('buffer', <f-args>)

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

                                                                                                     .vim/plugin/grep.vim                                                                                0000644 0001751 0001751 00000074373 12126773534 013573  0                                                                                                    ustar   x0199365                        x0199365                                                                                                                                                                                                               " File: grep.vim
" Author: Yegappan Lakshmanan (yegappan AT yahoo DOT com)
" Version: 1.9
" Last Modified: September 10, 2007
" 
" Overview
" --------
" The grep plugin integrates the grep, fgrep, egrep, and agrep tools with
" Vim and allows you to search for a pattern in one or more files and jump
" to them.
"
" To use this plugin, you need the grep, fgrep, egrep, agrep, find and
" xargs utilities. These tools are present in most of the Unix installations.
" For MS-Windows systems, you can download the GNU grep and find utilities
" from the following sites:
"
"    http://gnuwin32.sourceforge.net/packages/grep.htm
"    http://gnuwin32.sourceforge.net/packages/findutils.htm
"
" Installation
" ------------
" 1. Copy the grep.vim file to the $HOME/.vim/plugin or $HOME/vimfiles/plugin
"    or $VIM/vimfiles/plugin directory. 
"    Refer to the following Vim help topics for more information about Vim
"    plugins:
"       :help add-plugin
"       :help add-global-plugin
"       :help runtimepath
" 2. If the grep executables are not already present in one of the directories
"    in the PATH environment variable, then set the Grep_Path and other _Path
"    variables to point to the location of the grep utilites in the .vimrc
"    file.
" 3. Restart Vim.
" 4. You can now use the ":Grep" and other commands to search for patterns in
"    files.
"
" Usage
" -----
" The grep.vim plugin introduces the following Vim commands:
"
" :Grep          - Search for the specified pattern in the specified files
" :GrepAdd       - Same as ":Grep" but adds the results to the current results
" :Rgrep         - Run recursive grep
" :RgrepAdd      - Same as ":Rgrep" but adds the results to the current results
" :GrepBuffer    - Search for a pattern on all open buffers
" :GrepBufferAdd - Same as ":GrepBuffer" but adds the results to the current
"                  results
" :Bgrep         - Same as :GrepBuffer
" :BgrepAdd      - Same as :GrepBufferAdd
" :GrepArgs      - Search for a pattern on all the Vim argument 
"                  filenames (:args)
" :GrepArgsAdd   - Same as ":GrepArgs" but adds the results to the current
"                  results
" :Fgrep         - Run fgrep
" :FgrepAdd      - Same as ":Fgrep" but adds the results to the current
"                  results
" :Rfgrep        - Run recursive fgrep
" :RfgrepAdd     - Same as ":Rfgrep" but adds the results to the current
"                  results
" :Egrep         - Run egrep
" :EgrepAdd      - Same as ":Egrep" but adds the results to the current
"                  results
" :Regrep        - Run recursive egrep
" :RegrepAdd     - Same as ":Regrep" but adds the results to the current
"                  results
" :Agrep         - Run agrep
" :AgrepAdd      - Same as ":Agrep" but adds the results to the current
"                  results
" :Ragrep        - Run recursive agrep
" :RagrepAdd     - Same as ":Ragrep" but adds the results to the current
"                  results
"
" The above commands can be invoked like this:
"
"    :Grep   [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :Rgrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :Fgrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :Rfgrep [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :Egrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :Regrep [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :Agrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :Ragrep [<grep_options>] [<search_pattern> [<file_name(s)>]]
"
"    :GrepAdd   [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :RgrepAdd  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :FgrepAdd  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :RfgrepAdd [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :EgrepAdd  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :RegrepAdd [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :AgrepAdd  [<grep_options>] [<search_pattern> [<file_name(s)>]]
"    :RagrepAdd [<grep_options>] [<search_pattern> [<file_name(s)>]]
"
"    :GrepBuffer [<grep_options>] [<search_pattern>]
"    :Bgrep [<grep_options>] [<search_pattern>]
"    :GrepArgs [<grep_options>] [<search_pattern>]
"
"    :GrepBufferAdd [<grep_options>] [<search_pattern>]
"    :BgrepAdd [<grep_options>] [<search_pattern>]
"    :GrepArgsAdd [<grep_options>] [<search_pattern>]
"
" In the above commands, all the arguments are optional.
"
" You can specify grep options like -i (ignore case) or -w (search for a word)
" to the above commands.  If the <grep_options> are not specified, then the
" default grep options specified by the variable Grep_Default_Options is 
" used.
"
" You can specify the grep pattern to search as an argument to the above
" commands.  If the <search_pattern> is not specified, then you will be
" prompted to enter a search pattern. By default, the keyword under the cursor
" is displayed for the search pattern prompt. You can accept the default or
" modify it.
"
" The search pattern is automatically enclosed by the character specified in
" the Grep_Shell_Quote_Char variable. You should not enclose the search
" pattern with a shell escape character.
"
" If you want to specify a search pattern with space characters or a
" multi-word pattern, then you should use the Grep command pattern input
" prompt to supply the pattern.
"
" You can specify one or more file names (or file patterns) to the above
" commands.  If the <file_names> are not specified, then you will be prompted
" to enter file names.  By default, the pattern specified by the
" Grep_Default_Filelist variable is used. To specify the file name(s) as an
" argument to the above commands, you have to specify the search pattern also.
"
" When you enter only the command name, you will be prompted to enter the
" search pattern and the files in which to search for the pattern. By default,
" the keyword under the cursor is displayed for the search pattern prompt.
" Depending on the command, you may prompted for additional parameters like
" the directories to search for the pattern.
"
" You can retrieve previously entered values for the Grep prompts using the up
" and down arrow keys. You can cancel the command by pressing the escape key.
" You can use CTRL-U to erase the default shown for the prompt and CTRL-W to
" erase the previous word in the prompt. For more information about editing
" the prompt, read ':help cmdline-editing' Vim help topic.
"
" After invoking any of the grep commands, you can cancel the command, when
" you are prompted for a search pattern or file names or a directory by
" pressing the <Esc> key. You cannot cancel (or kill) the
" grep/fgrep/egrep/agrep commands after the external command is invoked.
"
" The GrepAdd, RgrepAdd and other *Add commands append the search output to
" the current search output. This is useful if you want to see the search
" results for multiple patterns at the same time. These commands are available
" only in Vim version 7.0 and above.
"
" You can map a key to invoke any of the above commands. For example, the
" following map invokes the :Grep command to search for the keyword under the
" cursor:
"
"       nnoremap <silent> <F3> :Grep<CR>
"
" The output of the grep command will be listed in the Vim quickfix window.
" 1. You can select a line in the quickfix window and press <Enter> or double
"    click on a match to jump to that line.
" 2. You can use the ":cnext" and ":cprev" commands to the jump to the next or
"    previous output line.
" 3. You can use the ":colder" and ":cnewer" commands to go between multiple
"    grep quickfix output windows.
" 4. The quickfix window need not be opened always to use the grep output.
"    You can close the quickfix window and use the quickfix commands to jump
"    to the grep matches.  Use the ":copen" command to open the quickfix
"    window again.
"
" For more information about other quickfix commands read ":help quickfix"
" 
" When using GUI Vim, the Tools->Search menu item with a few sub-menu items is
" created for few variations of the search command.
"
" Configuration
" -------------
" By changing the following variables you can configure the behavior of this
" plugin. Set the following variables in your .vimrc file using the 'let'
" command.
"
" The 'Grep_Path' variable is used to locate the grep utility. By default,
" this is set to grep. You can change this using the let command:
"
"       :let Grep_Path = 'd:\tools\grep.exe'
"
" The 'Fgrep_Path' variable is used to locate the fgrep utility. By default,
" this is set to fgrep. You can change this using the let command:
"
"       :let Fgrep_Path = 'd:\tools\fgrep.exe'
"
" The 'Egrep_Path' variable is used to locate the egrep utility. By default,
" this is set to egrep. You can change this using the let command:
"
"       :let Egrep_Path = 'd:\tools\egrep.exe'
"
" The 'Agrep_Path' variable is used to locate the agrep utility. By default,
" this is set to agrep. You can change this using the let command:
"
"       :let Agrep_Path = 'd:\tools\agrep.exe'
"
" The 'Grep_Find_Path' variable is used to locate the find utility. By
" default, this is set to d:\tools\find.exe. You can change this using the let
" command:
"
"       :let Grep_Find_Path = 'd:\tools\find.exe'
"
" The 'Grep_Xargs_Path' variable is used to locate the xargs utility. By
" default, this is set to xargs. You can change this using the let
" command:
"
"       :let Grep_Xargs_Path = 'd:\tools\xargs.exe'
"
" When running any one of the Grep commands, you will be prompted for the
" files in which to search for the pattern. The 'Grep_Default_Filelist'
" variable is used to specify to default for this prompt. By default, this
" variable is set to '*'. You can specify multiple matching patterns separated
" by spaces. You can change this settings using the let command:
"
"       :let Grep_Default_Filelist = '*.[chS]'
"       :let Grep_Default_Filelist = '*.c *.cpp *.asm'
"
" The 'Grep_Default_Options' is used to pass default command line options to
" the grep/fgrep/egrep/agrep utilities. By default, this is set to an empty
" string. You can change this using the let command:
"
"       :let Grep_Default_Options = '-i'
"
" The 'Grep_Skip_Dirs' variable specifies the list of directories to skip
" while doing recursive searches. By default, this is set to 'RCS CVS SCCS'.
" You can change this using the let command:
"
"       :let Grep_Skip_Dirs = 'dir1 dir2 dir3'
"
" The 'Grep_Skip_Files' variable specifies the list of files to skip while
" doing recursive searches. By default, this is set to '*~ *,v s.*'. You can
" change this using the let command:
"
"       :let Grep_Skip_Files = '*.bak *~'
"
" By default, when you invoke the Grep commands the quickfix window will be
" opened with the grep output.  You can disable opening the quickfix window,
" by setting the 'Grep_OpenQuickfixWindow' variable  to zero:
"
"       :let Grep_OpenQuickfixWindow = 0
"
" You can manually open the quickfix window using the :cwindow command.
"
" By default, for recursive searches, the 'find' and 'xargs' utilities are
" used.  If you don't have the 'xargs' utility or don't want to use the
" 'xargs' utility, " then you can set the 'Grep_Find_Use_Xargs' variable to
" zero. If this is set to zero, then only the 'find' utility is used for
" recursive searches:
"
"       :let Grep_Find_Use_Xargs = 0
" 
" To handle file names with space characters in them, the xargs utility
" is invoked with the '--null' argument. If the xargs utility in your system
" doesn't accept the '--null' argument, then you can change the
" Grep_Xargs_Options variable. For example, to use the '--print0' xargs
" argument, you can use the following command:
"
" 	:let Grep_Xargs_Options = '--print0'
"
" The Grep_Cygwin_Find variable should be set to 1, if you are using the find
" utility from the cygwin package. This setting is used to handle the
" difference between the backslash and forward slash path separators.
"
"       :let Grep_Cygwin_Find = 1
" 
" The 'Grep_Null_Device' variable specifies the name of the null device to
" pass to the grep commands. This is needed to force the grep commands to
" print the name of the file in which a match is found, if only one filename
" is specified. For Unix systems, this is set to /dev/null and for MS-Windows
" systems, this is set to NUL. You can modify this by using the let command:
"
"       :let Grep_Null_Device = '/dev/null'
"
" The 'Grep_Shell_Quote_Char' variable specifies the quote character to use
" for protecting patterns from being interpreted by the shell. For Unix
" systems, this is set to "'" and for MS-Window systems, this is set to an
" empty string.  You can change this using the let command:
"
"       :let Grep_Shell_Quote_Char = "'"
"
" The 'Grep_Shell_Escape_Char' variable specifies the escape character to use
" for protecting special characters from being interpreted by the shell.  For
" Unix systems, this is set to '\' and for MS-Window systems, this is set to
" an empty string.  You can change this using the let command:
"
"       :let Grep_Shell_Escape_Char = "'"
"
" --------------------- Do not modify after this line ---------------------
if exists("loaded_grep")
    finish
endif
let loaded_grep = 1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" Location of the grep utility
if !exists("Grep_Path")
    let Grep_Path = 'grep'
endif

" Location of the fgrep utility
if !exists("Fgrep_Path")
    let Fgrep_Path = 'fgrep'
endif

" Location of the egrep utility
if !exists("Egrep_Path")
    let Egrep_Path = 'egrep'
endif

" Location of the agrep utility
if !exists("Agrep_Path")
    let Agrep_Path = 'agrep'
endif

" Location of the find utility
if !exists("Grep_Find_Path")
    let Grep_Find_Path = 'find'
endif

" Location of the xargs utility
if !exists("Grep_Xargs_Path")
    let Grep_Xargs_Path = 'xargs'
endif

" Open the Grep output window.  Set this variable to zero, to not open
" the Grep output window by default.  You can open it manually by using
" the :cwindow command.
if !exists("Grep_OpenQuickfixWindow")
    let Grep_OpenQuickfixWindow = 1
endif

" Default grep file list
if !exists("Grep_Default_Filelist")
    let Grep_Default_Filelist = '*'
endif

" Default grep options
if !exists("Grep_Default_Options")
    let Grep_Default_Options = ''
endif

" Use the 'xargs' utility in combination with the 'find' utility. Set this
" to zero to not use the xargs utility.
if !exists("Grep_Find_Use_Xargs")
    let Grep_Find_Use_Xargs = 1
endif

" The command-line arguments to supply to the xargs utility
if !exists('Grep_Xargs_Options')
    let Grep_Xargs_Options = '--null'
endif

" The find utility is from the cygwin package or some other find utility.
if !exists("Grep_Cygwin_Find")
    let Grep_Cygwin_Find = 0
endif

" NULL device name to supply to grep.  We need this because, grep will not
" print the name of the file, if only one filename is supplied. We need the
" filename for Vim quickfix processing.
if !exists("Grep_Null_Device")
    if has("win32") || has("win16") || has("win95")
        let Grep_Null_Device = 'NUL'
    else
        let Grep_Null_Device = '/dev/null'
    endif
endif

" Character to use to quote patterns and filenames before passing to grep.
if !exists("Grep_Shell_Quote_Char")
    if has("win32") || has("win16") || has("win95")
        let Grep_Shell_Quote_Char = ''
    else
        let Grep_Shell_Quote_Char = "'"
    endif
endif

" Character to use to escape special characters before passing to grep.
if !exists("Grep_Shell_Escape_Char")
    if has("win32") || has("win16") || has("win95")
        let Grep_Shell_Escape_Char = ''
    else
        let Grep_Shell_Escape_Char = '\'
    endif
endif

" The list of directories to skip while searching for a pattern. Set this
" variable to '', if you don't want to skip directories.
if !exists("Grep_Skip_Dirs")
    let Grep_Skip_Dirs = 'RCS CVS SCCS'
endif

" The list of files to skip while searching for a pattern. Set this variable
" to '', if you don't want to skip any files.
if !exists("Grep_Skip_Files")
    let Grep_Skip_Files = '*~ *,v s.*'
endif

" RunGrepCmd()
" Run the specified grep command using the supplied pattern
function! s:RunGrepCmd(cmd, pattern, action)
    let cmd_output = system(a:cmd)

    if cmd_output == ""
        echohl WarningMsg | 
        \ echomsg "Error: Pattern " . a:pattern . " not found" | 
        \ echohl None
        return
    endif

    let tmpfile = tempname()

    let old_verbose = &verbose
    set verbose&vim

    exe "redir! > " . tmpfile
    silent echon '[Search results for pattern: ' . a:pattern . "]\n"
    silent echon cmd_output
    redir END

    let &verbose = old_verbose

    let old_efm = &efm
    set efm=%f:%\\s%#%l:%m

    if v:version >= 700 && a:action == 'add'
        execute "silent! caddfile " . tmpfile
    else
        if exists(":cgetfile")
            execute "silent! cgetfile " . tmpfile
        else
            execute "silent! cfile " . tmpfile
        endif
    endif

    let &efm = old_efm

    " Open the grep output window
    if g:Grep_OpenQuickfixWindow == 1
        " Open the quickfix window below the current window
        botright copen
    endif

    call delete(tmpfile)
endfunction

" RunGrepRecursive()
" Run specified grep command recursively
function! s:RunGrepRecursive(cmd_name, grep_cmd, action, ...)
    if a:0 > 0 && (a:1 == "-?" || a:1 == "-h")
        echo 'Usage: ' . a:cmd_name . " [<grep_options>] [<search_pattern> " .
                        \ "[<file_name(s)>]]"
        return
    endif

    let grep_opt    = ""
    let pattern     = ""
    let filepattern = ""

    let argcnt = 1
    while argcnt <= a:0
        if a:{argcnt} =~ '^-'
            let grep_opt = grep_opt . " " . a:{argcnt}
        elseif pattern == ""
            let pattern = g:Grep_Shell_Quote_Char . a:{argcnt} . 
                            \ g:Grep_Shell_Quote_Char
        else
            let filepattern = filepattern . " " . a:{argcnt}
        endif
        let argcnt= argcnt + 1
    endwhile
    if grep_opt == ""
        let grep_opt = g:Grep_Default_Options
    endif

    if a:grep_cmd != 'agrep'
        " Don't display messages about non-existent files
        " Agrep doesn't support the -s option
        let grep_opt = grep_opt . " -s"
    endif

    if a:grep_cmd == 'grep'
        let grep_path = g:Grep_Path
        let grep_expr_option = '--'
    elseif a:grep_cmd == 'fgrep'
        let grep_path = g:Fgrep_Path
        let grep_expr_option = '-e'
    elseif a:grep_cmd == 'egrep'
        let grep_path = g:Egrep_Path
        let grep_expr_option = '-e'
    elseif a:grep_cmd == 'agrep'
        let grep_path = g:Agrep_Path
        let grep_expr_option = ''
    else
        return
    endif

    " No argument supplied. Get the identifier and file list from user
    if pattern == "" 
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif
        let pattern = g:Grep_Shell_Quote_Char . pattern . 
                        \ g:Grep_Shell_Quote_Char
    endif

    let cwd = getcwd()
    if g:Grep_Cygwin_Find == 1
        let cwd = substitute(cwd, "\\", "/", "g")
    endif
    if v:version >= 700
        let startdir = input("Start searching from directory: ", cwd, "dir")
    else
        let startdir = input("Start searching from directory: ", cwd)
    endif
    if startdir == ""
        return
    endif

    if filepattern == ""
        let filepattern = input("Search in files matching pattern: ", 
                                          \ g:Grep_Default_Filelist)
        if filepattern == ""
            return
        endif
    endif

    let txt = filepattern . ' '
    let find_file_pattern = ''
    while txt != ''
        let one_pattern = strpart(txt, 0, stridx(txt, ' '))
        if find_file_pattern != ''
            let find_file_pattern = find_file_pattern . ' -o'
        endif
        let find_file_pattern = find_file_pattern . ' -name ' .
              \ g:Grep_Shell_Quote_Char . one_pattern . g:Grep_Shell_Quote_Char
        let txt = strpart(txt, stridx(txt, ' ') + 1)
    endwhile
    let find_file_pattern = g:Grep_Shell_Escape_Char . '(' .
                    \ find_file_pattern . ' ' . g:Grep_Shell_Escape_Char . ')'

    let txt = g:Grep_Skip_Dirs
    let find_prune = ''
    if txt != ''
        let txt = txt . ' '
        while txt != ''
            let one_dir = strpart(txt, 0, stridx(txt, ' '))
            if find_prune != ''
                let find_prune = find_prune . ' -o'
            endif
            let find_prune = find_prune . ' -name ' . one_dir
            let txt = strpart(txt, stridx(txt, ' ') + 1)
        endwhile
        let find_prune = '-type d ' . g:Grep_Shell_Escape_Char . '(' .
                         \ find_prune
        let find_prune = find_prune . ' ' . g:Grep_Shell_Escape_Char . ')'
    endif

    let txt = g:Grep_Skip_Files
    let find_skip_files = '-type f'
    if txt != ''
        let txt = txt . ' '
        while txt != ''
            let one_file = strpart(txt, 0, stridx(txt, ' '))
            let find_skip_files = find_skip_files . ' ! -name ' .
                                  \ g:Grep_Shell_Quote_Char . one_file .
                                  \ g:Grep_Shell_Quote_Char
            let txt = strpart(txt, stridx(txt, ' ') + 1)
        endwhile
    endif

    if g:Grep_Find_Use_Xargs == 1
        let cmd = g:Grep_Find_Path . " " . startdir
        let cmd = cmd . " " . find_prune . " -prune -o"
        let cmd = cmd . " " . find_skip_files
        let cmd = cmd . " " . find_file_pattern
        let cmd = cmd . " -print0 | "
        let cmd = cmd . g:Grep_Xargs_Path . ' ' . g:Grep_Xargs_Options
        let cmd = cmd . ' ' . grep_path . " " . grep_opt . " -n "
        let cmd = cmd . grep_expr_option . " " . pattern
        let cmd = cmd . ' ' . g:Grep_Null_Device 
    else
        let cmd = g:Grep_Find_Path . " " . startdir
        let cmd = cmd . " " . find_prune . " -prune -o"
        let cmd = cmd . " " . find_skip_files
        let cmd = cmd . " " . find_file_pattern
        let cmd = cmd . " -exec " . grep_path . " " . grep_opt . " -n "
        let cmd = cmd . grep_expr_option . " " . pattern
        let cmd = cmd . " {} " . g:Grep_Null_Device . ' ' .
                         \ g:Grep_Shell_Escape_Char . ';'
    endif

    call s:RunGrepCmd(cmd, pattern, a:action)
endfunction

" RunGrepSpecial()
" Search for a pattern in all the opened buffers or filenames in the
" argument list
function! s:RunGrepSpecial(cmd_name, which, action, ...)
    if a:0 > 0 && (a:1 == "-?" || a:1 == "-h")
        echo 'Usage: ' . a:cmd_name . " [<grep_options>] [<search_pattern>]"
        return
    endif

    " Search in all the Vim buffers
    if a:which == 'buffer'
        " Get a list of all the buffer names
        let last_bufno = bufnr("$")

        let i = 1
        let filenames = ""

        while i <= last_bufno
            if bufexists(i) && buflisted(i)
                let filenames = filenames . " " . bufname(i)
            endif
            let i = i + 1
        endwhile

        " No buffers
        if filenames == ""
            return
        endif
    elseif a:which == 'args'
        " Search in all the filenames in the argument list
        let arg_cnt = argc()

        if arg_cnt == 0
            echohl WarningMsg
            echomsg "Error: Argument list is empty"
            echohl None
            return
        endif

        let i = 0
        let filenames = ""

        while i < arg_cnt
            let filenames = filenames . " " . argv(i)
            let i = i + 1
        endwhile

        " No arguments
        if filenames == ""
            echohl WarningMsg
            echomsg "Error: Argument list is empty"
            echohl None
            return
        endif
    endif

    let grep_opt = ""
    let pattern = ""

    " Get the list of optional grep command-line options (if present)
    " supplied by the user. All the grep options will be preceded
    " by a '-'
    let argcnt= 1
    while argcnt <= a:0 && a:{argcnt} =~ '^-'
        let grep_opt = grep_opt . " " . a:{argcnt}
        let argcnt = argcnt + 1
    endwhile

    " If the user didn't specify the option, then use the defaults
    if grep_opt == ""
        let grep_opt = g:Grep_Default_Options
    endif

    " Don't display messages about non-existent files
    let grep_opt = grep_opt . " -s"

    " The last argument specified by the user is the pattern
    if argcnt == a:0
        let pattern = a:{argcnt}
    else
        " No argument supplied. Get the identifier and file list from user
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif
    endif

    let pattern = g:Grep_Shell_Quote_Char . pattern . g:Grep_Shell_Quote_Char

    " Add /dev/null to the list of filenames, so that grep print the
    " filename and linenumber when grepping in a single file
    let filenames = filenames . " " . g:Grep_Null_Device
    let cmd = g:Grep_Path . " " . grep_opt . " -n -- "
    let cmd = cmd . pattern . " " . filenames

    call s:RunGrepCmd(cmd, pattern, a:action)
endfunction

" RunGrep()
" Run the specified grep command
function! s:RunGrep(cmd_name, grep_cmd, action, ...)
    if a:0 > 0 && (a:1 == "-?" || a:1 == "-h")
        echo 'Usage: ' . a:cmd_name . " [<grep_options>] [<search_pattern> " .
                        \ "[<file_name(s)>]]"
        return
    endif

    let grep_opt  = ""
    let pattern   = ""
    let filenames = ""

    " Parse the arguments
    " grep command-line flags are specified using the "-flag" format
    " the next argument is assumed to be the pattern
    " and the next arguments are assumed to be filenames or file patterns
    let argcnt = 1
    while argcnt <= a:0
        if a:{argcnt} =~ '^-'
            let grep_opt = grep_opt . " " . a:{argcnt}
        elseif pattern == ""
            let pattern = g:Grep_Shell_Quote_Char . a:{argcnt} .
                            \ g:Grep_Shell_Quote_Char
        else
            let filenames= filenames . " " . a:{argcnt}
        endif
        let argcnt = argcnt + 1
    endwhile

    if grep_opt == ""
        let grep_opt = g:Grep_Default_Options
    endif

    if a:grep_cmd != 'agrep'
        " Don't display messages about non-existent files
        " Agrep doesn't support the -s option
        let grep_opt = grep_opt . " -s"
    endif

    if a:grep_cmd == 'grep'
        let grep_path = g:Grep_Path
        let grep_expr_option = '--'
    elseif a:grep_cmd == 'fgrep'
        let grep_path = g:Fgrep_Path
        let grep_expr_option = '-e'
    elseif a:grep_cmd == 'egrep'
        let grep_path = g:Egrep_Path
        let grep_expr_option = '-e'
    elseif a:grep_cmd == 'agrep'
        let grep_path = g:Agrep_Path
        let grep_expr_option = ''
    else
        return
    endif

    " Get the identifier and file list from user
    if pattern == "" 
        let pattern = input("Search for pattern: ", expand("<cword>"))
        if pattern == ""
            return
        endif
        let pattern = g:Grep_Shell_Quote_Char . pattern .
                        \ g:Grep_Shell_Quote_Char
    endif

    if filenames == ""
        if v:version >= 700
            let filenames = input("Search in files: ", g:Grep_Default_Filelist,
                        \ "file")
        else
            let filenames = input("Search in files: ", g:Grep_Default_Filelist)
        endif
        if filenames == ""
            return
        endif
    endif

    " Add /dev/null to the list of filenames, so that grep print the
    " filename and linenumber when grepping in a single file
    let filenames = filenames . " " . g:Grep_Null_Device
    let cmd = grep_path . " " . grep_opt . " -n "
    let cmd = cmd . grep_expr_option . " " . pattern
    let cmd = cmd . " " . filenames

    call s:RunGrepCmd(cmd, pattern, a:action)
endfunction

" Define the set of grep commands
command! -nargs=* -complete=file Grep
            \ call s:RunGrep('Grep', 'grep', 'set', <f-args>)
command! -nargs=* -complete=file Rgrep
            \ call s:RunGrepRecursive('Rgrep', 'grep', 'set', <f-args>)
command! -nargs=* GrepBuffer
            \ call s:RunGrepSpecial('GrepBuffer', 'buffer', 'set', <f-args>)
command! -nargs=* Bgrep
            \ call s:RunGrepSpecial('Bgrep', 'buffer', 'set', <f-args>)
command! -nargs=* GrepArgs
            \ call s:RunGrepSpecial('GrepArgs', 'args', 'set', <f-args>)

command! -nargs=* -complete=file Fgrep
            \ call s:RunGrep('Fgrep', 'fgrep', 'set', <f-args>)
command! -nargs=* -complete=file Rfgrep
            \ call s:RunGrepRecursive('Rfgrep', 'fgrep', 'set', <f-args>)
command! -nargs=* -complete=file Egrep
            \ call s:RunGrep('Egrep', 'egrep', 'set', <f-args>)
command! -nargs=* -complete=file Regrep
            \ call s:RunGrepRecursive('Regrep', 'egrep', 'set', <f-args>)
command! -nargs=* -complete=file Agrep
            \ call s:RunGrep('Agrep', 'agrep', 'set', <f-args>)
command! -nargs=* -complete=file Ragrep
            \ call s:RunGrepRecursive('Ragrep', 'agrep', 'set', <f-args>)

if v:version >= 700
command! -nargs=* -complete=file GrepAdd
            \ call s:RunGrep('GrepAdd', 'grep', 'add', <f-args>)
command! -nargs=* -complete=file RgrepAdd
            \ call s:RunGrepRecursive('RgrepAdd', 'grep', 'add', <f-args>)
command! -nargs=* GrepBufferAdd
            \ call s:RunGrepSpecial('GrepBufferAdd', 'buffer', 'add', <f-args>)
command! -nargs=* BgrepAdd
            \ call s:RunGrepSpecial('BgrepAdd', 'buffer', 'add', <f-args>)
command! -nargs=* GrepArgsAdd
            \ call s:RunGrepSpecial('GrepArgsAdd', 'args', 'add', <f-args>)

command! -nargs=* -complete=file FgrepAdd
            \ call s:RunGrep('FgrepAdd', 'fgrep', 'add', <f-args>)
command! -nargs=* -complete=file RfgrepAdd
            \ call s:RunGrepRecursive('RfgrepAdd', 'fgrep', 'add', <f-args>)
command! -nargs=* -complete=file EgrepAdd
            \ call s:RunGrep('EgrepAdd', 'egrep', 'add', <f-args>)
command! -nargs=* -complete=file RegrepAdd
            \ call s:RunGrepRecursive('RegrepAdd', 'egrep', 'add', <f-args>)
command! -nargs=* -complete=file AgrepAdd
            \ call s:RunGrep('AgrepAdd', 'agrep', 'add', <f-args>)
command! -nargs=* -complete=file RagrepAdd
            \ call s:RunGrepRecursive('RagrepAdd', 'agrep', 'add', <f-args>)
endif

" Add the Tools->Search Files menu
if has('gui_running')
    anoremenu <silent> Tools.Search.Current\ Directory<Tab>:Grep
                \ :Grep<CR>
    anoremenu <silent> Tools.Search.Recursively<Tab>:Rgrep
                \ :Rgrep<CR>
    anoremenu <silent> Tools.Search.Buffer\ List<Tab>:Bgrep
                \ :Bgrep<CR>
    anoremenu <silent> Tools.Search.Argument\ List<Tab>:GrepArgs
                \ :GrepArgs<CR>
endif

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

                                                                                                                                                                                                                                                                     .vim/plugin/NERD_tree.vim                                                                           0000644 0001751 0001751 00000372016 12126773534 014400  0                                                                                                    ustar   x0199365                        x0199365                                                                                                                                                                                                               " ============================================================================
" File:        NERD_tree.vim
" Description: vim global plugin that provides a nice tree explorer
" Maintainer:  Martin Grenfell <martin.grenfell at gmail dot com>
" Last Change: 1 December, 2009
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================
let s:NERD_tree_version = '4.1.0'

" SECTION: Script init stuff {{{1
"============================================================
if exists("loaded_nerd_tree")
    finish
endif
if v:version < 700
    echoerr "NERDTree: this plugin requires vim >= 7. DOWNLOAD IT! You'll thank me later!"
    finish
endif
let loaded_nerd_tree = 1

"for line continuation - i.e dont want C in &cpo
let s:old_cpo = &cpo
set cpo&vim

"Function: s:initVariable() function {{{2
"This function is used to initialise a given variable to a given value. The
"variable is only initialised if it does not exist prior
"
"Args:
"var: the name of the var to be initialised
"value: the value to initialise var to
"
"Returns:
"1 if the var is set, 0 otherwise
function! s:initVariable(var, value)
    if !exists(a:var)
        exec 'let ' . a:var . ' = ' . "'" . a:value . "'"
        return 1
    endif
    return 0
endfunction

"SECTION: Init variable calls and other random constants {{{2
call s:initVariable("g:NERDChristmasTree", 1)
call s:initVariable("g:NERDTreeAutoCenter", 1)
call s:initVariable("g:NERDTreeAutoCenterThreshold", 3)
call s:initVariable("g:NERDTreeCaseSensitiveSort", 0)
call s:initVariable("g:NERDTreeChDirMode", 0)
if !exists("g:NERDTreeIgnore")
    let g:NERDTreeIgnore = ['\~$']
endif
call s:initVariable("g:NERDTreeBookmarksFile", expand('$HOME') . '/.NERDTreeBookmarks')
call s:initVariable("g:NERDTreeHighlightCursorline", 1)
call s:initVariable("g:NERDTreeHijackNetrw", 1)
call s:initVariable("g:NERDTreeMouseMode", 1)
call s:initVariable("g:NERDTreeNotificationThreshold", 100)
call s:initVariable("g:NERDTreeQuitOnOpen", 0)
call s:initVariable("g:NERDTreeShowBookmarks", 0)
call s:initVariable("g:NERDTreeShowFiles", 1)
call s:initVariable("g:NERDTreeShowHidden", 0)
call s:initVariable("g:NERDTreeShowLineNumbers", 0)
call s:initVariable("g:NERDTreeSortDirs", 1)

if !exists("g:NERDTreeSortOrder")
    let g:NERDTreeSortOrder = ['\/$', '*', '\.swp$',  '\.bak$', '\~$']
else
    "if there isnt a * in the sort sequence then add one
    if count(g:NERDTreeSortOrder, '*') < 1
        call add(g:NERDTreeSortOrder, '*')
    endif
endif

"we need to use this number many times for sorting... so we calculate it only
"once here
let s:NERDTreeSortStarIndex = index(g:NERDTreeSortOrder, '*')

if !exists('g:NERDTreeStatusline')

    "the exists() crap here is a hack to stop vim spazzing out when
    "loading a session that was created with an open nerd tree. It spazzes
    "because it doesnt store b:NERDTreeRoot (its a b: var, and its a hash)
    let g:NERDTreeStatusline = "%{exists('b:NERDTreeRoot')?b:NERDTreeRoot.path.str():''}"

endif
call s:initVariable("g:NERDTreeWinPos", "left")
call s:initVariable("g:NERDTreeWinSize", 31)

let s:running_windows = has("win16") || has("win32") || has("win64")

"init the shell commands that will be used to copy nodes, and remove dir trees
"
"Note: the space after the command is important
if s:running_windows
    call s:initVariable("g:NERDTreeRemoveDirCmd", 'rmdir /s /q ')
else
    call s:initVariable("g:NERDTreeRemoveDirCmd", 'rm -rf ')
    call s:initVariable("g:NERDTreeCopyCmd", 'cp -r ')
endif


"SECTION: Init variable calls for key mappings {{{2
call s:initVariable("g:NERDTreeMapActivateNode", "o")
call s:initVariable("g:NERDTreeMapChangeRoot", "C")
call s:initVariable("g:NERDTreeMapChdir", "cd")
call s:initVariable("g:NERDTreeMapCloseChildren", "X")
call s:initVariable("g:NERDTreeMapCloseDir", "x")
call s:initVariable("g:NERDTreeMapDeleteBookmark", "D")
call s:initVariable("g:NERDTreeMapMenu", "m")
call s:initVariable("g:NERDTreeMapHelp", "?")
call s:initVariable("g:NERDTreeMapJumpFirstChild", "K")
call s:initVariable("g:NERDTreeMapJumpLastChild", "J")
call s:initVariable("g:NERDTreeMapJumpNextSibling", "<C-j>")
call s:initVariable("g:NERDTreeMapJumpParent", "p")
call s:initVariable("g:NERDTreeMapJumpPrevSibling", "<C-k>")
call s:initVariable("g:NERDTreeMapJumpRoot", "P")
call s:initVariable("g:NERDTreeMapOpenExpl", "e")
call s:initVariable("g:NERDTreeMapOpenInTab", "t")
call s:initVariable("g:NERDTreeMapOpenInTabSilent", "T")
call s:initVariable("g:NERDTreeMapOpenRecursively", "O")
call s:initVariable("g:NERDTreeMapOpenSplit", "i")
call s:initVariable("g:NERDTreeMapOpenVSplit", "s")
call s:initVariable("g:NERDTreeMapPreview", "g" . NERDTreeMapActivateNode)
call s:initVariable("g:NERDTreeMapPreviewSplit", "g" . NERDTreeMapOpenSplit)
call s:initVariable("g:NERDTreeMapPreviewVSplit", "g" . NERDTreeMapOpenVSplit)
call s:initVariable("g:NERDTreeMapQuit", "q")
call s:initVariable("g:NERDTreeMapRefresh", "r")
call s:initVariable("g:NERDTreeMapRefreshRoot", "R")
call s:initVariable("g:NERDTreeMapToggleBookmarks", "B")
call s:initVariable("g:NERDTreeMapToggleFiles", "F")
call s:initVariable("g:NERDTreeMapToggleFilters", "f")
call s:initVariable("g:NERDTreeMapToggleHidden", "I")
call s:initVariable("g:NERDTreeMapToggleZoom", "A")
call s:initVariable("g:NERDTreeMapUpdir", "u")
call s:initVariable("g:NERDTreeMapUpdirKeepOpen", "U")

"SECTION: Script level variable declaration{{{2
if s:running_windows
    let s:escape_chars =  " `\|\"#%&,?()\*^<>"
else
    let s:escape_chars =  " \\`\|\"#%&,?()\*^<>"
endif
let s:NERDTreeBufName = 'NERD_tree_'

let s:tree_wid = 2
let s:tree_markup_reg = '^[ `|]*[\-+~]'
let s:tree_up_dir_line = '.. (up a dir)'

"the number to add to the nerd tree buffer name to make the buf name unique
let s:next_buffer_number = 1

" SECTION: Commands {{{1
"============================================================
"init the command that users start the nerd tree with
command! -n=? -complete=dir -bar NERDTree :call s:initNerdTree('<args>')
command! -n=? -complete=dir -bar NERDTreeToggle :call s:toggle('<args>')
command! -n=0 -bar NERDTreeClose :call s:closeTreeIfOpen()
command! -n=1 -complete=customlist,s:completeBookmarks -bar NERDTreeFromBookmark call s:initNerdTree('<args>')
command! -n=0 -bar NERDTreeMirror call s:initNerdTreeMirror()
command! -n=0 -bar NERDTreeFind call s:findAndRevealPath()
" SECTION: Auto commands {{{1
"============================================================
augroup NERDTree
    "Save the cursor position whenever we close the nerd tree
    exec "autocmd BufWinLeave ". s:NERDTreeBufName ."* call <SID>saveScreenState()"
    "cache bookmarks when vim loads
    autocmd VimEnter * call s:Bookmark.CacheBookmarks(0)

    "load all nerdtree plugins after vim starts
    autocmd VimEnter * runtime! nerdtree_plugin/**/*.vim
augroup END

if g:NERDTreeHijackNetrw
    augroup NERDTreeHijackNetrw
        autocmd VimEnter * silent! autocmd! FileExplorer
        au BufEnter,VimEnter * call s:checkForBrowse(expand("<amatch>"))
    augroup END
endif

"SECTION: Classes {{{1
"============================================================
"CLASS: Bookmark {{{2
"============================================================
let s:Bookmark = {}
" FUNCTION: Bookmark.activate() {{{3
function! s:Bookmark.activate()
    if self.path.isDirectory
        call self.toRoot()
    else
        if self.validate()
            let n = s:TreeFileNode.New(self.path)
            call n.open()
        endif
    endif
endfunction
" FUNCTION: Bookmark.AddBookmark(name, path) {{{3
" Class method to add a new bookmark to the list, if a previous bookmark exists
" with the same name, just update the path for that bookmark
function! s:Bookmark.AddBookmark(name, path)
    for i in s:Bookmark.Bookmarks()
        if i.name ==# a:name
            let i.path = a:path
            return
        endif
    endfor
    call add(s:Bookmark.Bookmarks(), s:Bookmark.New(a:name, a:path))
    call s:Bookmark.Sort()
endfunction
" Function: Bookmark.Bookmarks()   {{{3
" Class method to get all bookmarks. Lazily initializes the bookmarks global
" variable
function! s:Bookmark.Bookmarks()
    if !exists("g:NERDTreeBookmarks")
        let g:NERDTreeBookmarks = []
    endif
    return g:NERDTreeBookmarks
endfunction
" Function: Bookmark.BookmarkExistsFor(name)   {{{3
" class method that returns 1 if a bookmark with the given name is found, 0
" otherwise
function! s:Bookmark.BookmarkExistsFor(name)
    try
        call s:Bookmark.BookmarkFor(a:name)
        return 1
    catch /^NERDTree.BookmarkNotFoundError/
        return 0
    endtry
endfunction
" Function: Bookmark.BookmarkFor(name)   {{{3
" Class method to get the bookmark that has the given name. {} is return if no
" bookmark is found
function! s:Bookmark.BookmarkFor(name)
    for i in s:Bookmark.Bookmarks()
        if i.name ==# a:name
            return i
        endif
    endfor
    throw "NERDTree.BookmarkNotFoundError: no bookmark found for name: \"". a:name  .'"'
endfunction
" Function: Bookmark.BookmarkNames()   {{{3
" Class method to return an array of all bookmark names
function! s:Bookmark.BookmarkNames()
    let names = []
    for i in s:Bookmark.Bookmarks()
        call add(names, i.name)
    endfor
    return names
endfunction
" FUNCTION: Bookmark.CacheBookmarks(silent) {{{3
" Class method to read all bookmarks from the bookmarks file intialize
" bookmark objects for each one.
"
" Args:
" silent - dont echo an error msg if invalid bookmarks are found
function! s:Bookmark.CacheBookmarks(silent)
    if filereadable(g:NERDTreeBookmarksFile)
        let g:NERDTreeBookmarks = []
        let g:NERDTreeInvalidBookmarks = []
        let bookmarkStrings = readfile(g:NERDTreeBookmarksFile)
        let invalidBookmarksFound = 0
        for i in bookmarkStrings

            "ignore blank lines
            if i != ''

                let name = substitute(i, '^\(.\{-}\) .*$', '\1', '')
                let path = substitute(i, '^.\{-} \(.*\)$', '\1', '')

                try
                    let bookmark = s:Bookmark.New(name, s:Path.New(path))
                    call add(g:NERDTreeBookmarks, bookmark)
                catch /^NERDTree.InvalidArgumentsError/
                    call add(g:NERDTreeInvalidBookmarks, i)
                    let invalidBookmarksFound += 1
                endtry
            endif
        endfor
        if invalidBookmarksFound
            call s:Bookmark.Write()
            if !a:silent
                call s:echo(invalidBookmarksFound . " invalid bookmarks were read. See :help NERDTreeInvalidBookmarks for info.")
            endif
        endif
        call s:Bookmark.Sort()
    endif
endfunction
" FUNCTION: Bookmark.compareTo(otherbookmark) {{{3
" Compare these two bookmarks for sorting purposes
function! s:Bookmark.compareTo(otherbookmark)
    return a:otherbookmark.name < self.name
endfunction
" FUNCTION: Bookmark.ClearAll() {{{3
" Class method to delete all bookmarks.
function! s:Bookmark.ClearAll()
    for i in s:Bookmark.Bookmarks()
        call i.delete()
    endfor
    call s:Bookmark.Write()
endfunction
" FUNCTION: Bookmark.delete() {{{3
" Delete this bookmark. If the node for this bookmark is under the current
" root, then recache bookmarks for its Path object
function! s:Bookmark.delete()
    let node = {}
    try
        let node = self.getNode(1)
    catch /^NERDTree.BookmarkedNodeNotFoundError/
    endtry
    call remove(s:Bookmark.Bookmarks(), index(s:Bookmark.Bookmarks(), self))
    if !empty(node)
        call node.path.cacheDisplayString()
    endif
    call s:Bookmark.Write()
endfunction
" FUNCTION: Bookmark.getNode(searchFromAbsoluteRoot) {{{3
" Gets the treenode for this bookmark
"
" Args:
" searchFromAbsoluteRoot: specifies whether we should search from the current
" tree root, or the highest cached node
function! s:Bookmark.getNode(searchFromAbsoluteRoot)
    let searchRoot = a:searchFromAbsoluteRoot ? s:TreeDirNode.AbsoluteTreeRoot() : b:NERDTreeRoot
    let targetNode = searchRoot.findNode(self.path)
    if empty(targetNode)
        throw "NERDTree.BookmarkedNodeNotFoundError: no node was found for bookmark: " . self.name
    endif
    return targetNode
endfunction
" FUNCTION: Bookmark.GetNodeForName(name, searchFromAbsoluteRoot) {{{3
" Class method that finds the bookmark with the given name and returns the
" treenode for it.
function! s:Bookmark.GetNodeForName(name, searchFromAbsoluteRoot)
    let bookmark = s:Bookmark.BookmarkFor(a:name)
    return bookmark.getNode(a:searchFromAbsoluteRoot)
endfunction
" FUNCTION: Bookmark.GetSelected() {{{3
" returns the Bookmark the cursor is over, or {}
function! s:Bookmark.GetSelected()
    let line = getline(".")
    let name = substitute(line, '^>\(.\{-}\) .\+$', '\1', '')
    if name != line
        try
            return s:Bookmark.BookmarkFor(name)
        catch /^NERDTree.BookmarkNotFoundError/
            return {}
        endtry
    endif
    return {}
endfunction

" Function: Bookmark.InvalidBookmarks()   {{{3
" Class method to get all invalid bookmark strings read from the bookmarks
" file
function! s:Bookmark.InvalidBookmarks()
    if !exists("g:NERDTreeInvalidBookmarks")
        let g:NERDTreeInvalidBookmarks = []
    endif
    return g:NERDTreeInvalidBookmarks
endfunction
" FUNCTION: Bookmark.mustExist() {{{3
function! s:Bookmark.mustExist()
    if !self.path.exists()
        call s:Bookmark.CacheBookmarks(1)
        throw "NERDTree.BookmarkPointsToInvalidLocationError: the bookmark \"".
            \ self.name ."\" points to a non existing location: \"". self.path.str()
    endif
endfunction
" FUNCTION: Bookmark.New(name, path) {{{3
" Create a new bookmark object with the given name and path object
function! s:Bookmark.New(name, path)
    if a:name =~ ' '
        throw "NERDTree.IllegalBookmarkNameError: illegal name:" . a:name
    endif

    let newBookmark = copy(self)
    let newBookmark.name = a:name
    let newBookmark.path = a:path
    return newBookmark
endfunction
" FUNCTION: Bookmark.openInNewTab(options) {{{3
" Create a new bookmark object with the given name and path object
function! s:Bookmark.openInNewTab(options)
    let currentTab = tabpagenr()
    if self.path.isDirectory
        tabnew
        call s:initNerdTree(self.name)
    else
        exec "tabedit " . bookmark.path.str({'format': 'Edit'})
    endif

    if has_key(a:options, 'stayInCurrentTab')
        exec "tabnext " . currentTab
    endif
endfunction
" Function: Bookmark.setPath(path)   {{{3
" makes this bookmark point to the given path
function! s:Bookmark.setPath(path)
    let self.path = a:path
endfunction
" Function: Bookmark.Sort()   {{{3
" Class method that sorts all bookmarks
function! s:Bookmark.Sort()
    let CompareFunc = function("s:compareBookmarks")
    call sort(s:Bookmark.Bookmarks(), CompareFunc)
endfunction
" Function: Bookmark.str()   {{{3
" Get the string that should be rendered in the view for this bookmark
function! s:Bookmark.str()
    let pathStrMaxLen = winwidth(s:getTreeWinNum()) - 4 - len(self.name)
    if &nu
        let pathStrMaxLen = pathStrMaxLen - &numberwidth
    endif

    let pathStr = self.path.str({'format': 'UI'})
    if len(pathStr) > pathStrMaxLen
        let pathStr = '<' . strpart(pathStr, len(pathStr) - pathStrMaxLen)
    endif
    return '>' . self.name . ' ' . pathStr
endfunction
" FUNCTION: Bookmark.toRoot() {{{3
" Make the node for this bookmark the new tree root
function! s:Bookmark.toRoot()
    if self.validate()
        try
            let targetNode = self.getNode(1)
        catch /^NERDTree.BookmarkedNodeNotFoundError/
            let targetNode = s:TreeFileNode.New(s:Bookmark.BookmarkFor(self.name).path)
        endtry
        call targetNode.makeRoot()
        call s:renderView()
        call targetNode.putCursorHere(0, 0)
    endif
endfunction
" FUNCTION: Bookmark.ToRoot(name) {{{3
" Make the node for this bookmark the new tree root
function! s:Bookmark.ToRoot(name)
    let bookmark = s:Bookmark.BookmarkFor(a:name)
    call bookmark.toRoot()
endfunction


"FUNCTION: Bookmark.validate() {{{3
function! s:Bookmark.validate()
    if self.path.exists()
        return 1
    else
        call s:Bookmark.CacheBookmarks(1)
        call s:renderView()
        call s:echo(self.name . "now points to an invalid location. See :help NERDTreeInvalidBookmarks for info.")
        return 0
    endif
endfunction

" Function: Bookmark.Write()   {{{3
" Class method to write all bookmarks to the bookmarks file
function! s:Bookmark.Write()
    let bookmarkStrings = []
    for i in s:Bookmark.Bookmarks()
        call add(bookmarkStrings, i.name . ' ' . i.path.str())
    endfor

    "add a blank line before the invalid ones
    call add(bookmarkStrings, "")

    for j in s:Bookmark.InvalidBookmarks()
        call add(bookmarkStrings, j)
    endfor
    call writefile(bookmarkStrings, g:NERDTreeBookmarksFile)
endfunction
"CLASS: KeyMap {{{2
"============================================================
let s:KeyMap = {}
"FUNCTION: KeyMap.All() {{{3
function! s:KeyMap.All()
    if !exists("s:keyMaps")
        let s:keyMaps = []
    endif
    return s:keyMaps
endfunction

"FUNCTION: KeyMap.BindAll() {{{3
function! s:KeyMap.BindAll()
    for i in s:KeyMap.All()
        call i.bind()
    endfor
endfunction

"FUNCTION: KeyMap.bind() {{{3
function! s:KeyMap.bind()
    exec "nnoremap <silent> <buffer> ". self.key ." :call ". self.callback ."()<cr>"
endfunction

"FUNCTION: KeyMap.Create(options) {{{3
function! s:KeyMap.Create(options)
    let newKeyMap = copy(self)
    let newKeyMap.key = a:options['key']
    let newKeyMap.quickhelpText = a:options['quickhelpText']
    let newKeyMap.callback = a:options['callback']
    call add(s:KeyMap.All(), newKeyMap)
endfunction
"CLASS: MenuController {{{2
"============================================================
let s:MenuController = {}
"FUNCTION: MenuController.New(menuItems) {{{3
"create a new menu controller that operates on the given menu items
function! s:MenuController.New(menuItems)
    let newMenuController =  copy(self)
    if a:menuItems[0].isSeparator()
        let newMenuController.menuItems = a:menuItems[1:-1]
    else
        let newMenuController.menuItems = a:menuItems
    endif
    return newMenuController
endfunction

"FUNCTION: MenuController.showMenu() {{{3
"start the main loop of the menu and get the user to choose/execute a menu
"item
function! s:MenuController.showMenu()
    call self._saveOptions()

    try
        let self.selection = 0

        let done = 0
        while !done
            redraw!
            call self._echoPrompt()
            let key = nr2char(getchar())
            let done = self._handleKeypress(key)
        endwhile
    finally
        call self._restoreOptions()
    endtry

    if self.selection != -1
        let m = self._current()
        call m.execute()
    endif
endfunction

"FUNCTION: MenuController._echoPrompt() {{{3
function! s:MenuController._echoPrompt()
    echo "NERDTree Menu. Use j/k/enter and the shortcuts indicated"
    echo "=========================================================="

    for i in range(0, len(self.menuItems)-1)
        if self.selection == i
            echo "> " . self.menuItems[i].text
        else
            echo "  " . self.menuItems[i].text
        endif
    endfor
endfunction

"FUNCTION: MenuController._current(key) {{{3
"get the MenuItem that is curently selected
function! s:MenuController._current()
    return self.menuItems[self.selection]
endfunction

"FUNCTION: MenuController._handleKeypress(key) {{{3
"change the selection (if appropriate) and return 1 if the user has made
"their choice, 0 otherwise
function! s:MenuController._handleKeypress(key)
    if a:key == 'j'
        call self._cursorDown()
    elseif a:key == 'k'
        call self._cursorUp()
    elseif a:key == nr2char(27) "escape
        let self.selection = -1
        return 1
    elseif a:key == "\r" || a:key == "\n" "enter and ctrl-j
        return 1
    else
        let index = self._nextIndexFor(a:key)
        if index != -1
            let self.selection = index
            if len(self._allIndexesFor(a:key)) == 1
                return 1
            endif
        endif
    endif

    return 0
endfunction

"FUNCTION: MenuController._allIndexesFor(shortcut) {{{3
"get indexes to all menu items with the given shortcut
function! s:MenuController._allIndexesFor(shortcut)
    let toReturn = []

    for i in range(0, len(self.menuItems)-1)
        if self.menuItems[i].shortcut == a:shortcut
            call add(toReturn, i)
        endif
    endfor

    return toReturn
endfunction

"FUNCTION: MenuController._nextIndexFor(shortcut) {{{3
"get the index to the next menu item with the given shortcut, starts from the
"current cursor location and wraps around to the top again if need be
function! s:MenuController._nextIndexFor(shortcut)
    for i in range(self.selection+1, len(self.menuItems)-1)
        if self.menuItems[i].shortcut == a:shortcut
            return i
        endif
    endfor

    for i in range(0, self.selection)
        if self.menuItems[i].shortcut == a:shortcut
            return i
        endif
    endfor

    return -1
endfunction

"FUNCTION: MenuController._setCmdheight() {{{3
"sets &cmdheight to whatever is needed to display the menu
function! s:MenuController._setCmdheight()
    let &cmdheight = len(self.menuItems) + 3
endfunction

"FUNCTION: MenuController._saveOptions() {{{3
"set any vim options that are required to make the menu work (saving their old
"values)
function! s:MenuController._saveOptions()
    let self._oldLazyredraw = &lazyredraw
    let self._oldCmdheight = &cmdheight
    set nolazyredraw
    call self._setCmdheight()
endfunction

"FUNCTION: MenuController._restoreOptions() {{{3
"restore the options we saved in _saveOptions()
function! s:MenuController._restoreOptions()
    let &cmdheight = self._oldCmdheight
    let &lazyredraw = self._oldLazyredraw
endfunction

"FUNCTION: MenuController._cursorDown() {{{3
"move the cursor to the next menu item, skipping separators
function! s:MenuController._cursorDown()
    let done = 0
    while !done
        if self.selection < len(self.menuItems)-1
            let self.selection += 1
        else
            let self.selection = 0
        endif

        if !self._current().isSeparator()
            let done = 1
        endif
    endwhile
endfunction

"FUNCTION: MenuController._cursorUp() {{{3
"move the cursor to the previous menu item, skipping separators
function! s:MenuController._cursorUp()
    let done = 0
    while !done
        if self.selection > 0
            let self.selection -= 1
        else
            let self.selection = len(self.menuItems)-1
        endif

        if !self._current().isSeparator()
            let done = 1
        endif
    endwhile
endfunction

"CLASS: MenuItem {{{2
"============================================================
let s:MenuItem = {}
"FUNCTION: MenuItem.All() {{{3
"get all top level menu items
function! s:MenuItem.All()
    if !exists("s:menuItems")
        let s:menuItems = []
    endif
    return s:menuItems
endfunction

"FUNCTION: MenuItem.AllEnabled() {{{3
"get all top level menu items that are currently enabled
function! s:MenuItem.AllEnabled()
    let toReturn = []
    for i in s:MenuItem.All()
        if i.enabled()
            call add(toReturn, i)
        endif
    endfor
    return toReturn
endfunction

"FUNCTION: MenuItem.Create(options) {{{3
"make a new menu item and add it to the global list
function! s:MenuItem.Create(options)
    let newMenuItem = copy(self)

    let newMenuItem.text = a:options['text']
    let newMenuItem.shortcut = a:options['shortcut']
    let newMenuItem.children = []

    let newMenuItem.isActiveCallback = -1
    if has_key(a:options, 'isActiveCallback')
        let newMenuItem.isActiveCallback = a:options['isActiveCallback']
    endif

    let newMenuItem.callback = -1
    if has_key(a:options, 'callback')
        let newMenuItem.callback = a:options['callback']
    endif

    if has_key(a:options, 'parent')
        call add(a:options['parent'].children, newMenuItem)
    else
        call add(s:MenuItem.All(), newMenuItem)
    endif

    return newMenuItem
endfunction

"FUNCTION: MenuItem.CreateSeparator(options) {{{3
"make a new separator menu item and add it to the global list
function! s:MenuItem.CreateSeparator(options)
    let standard_options = { 'text': '--------------------',
                \ 'shortcut': -1,
                \ 'callback': -1 }
    let options = extend(a:options, standard_options, "force")

    return s:MenuItem.Create(options)
endfunction

"FUNCTION: MenuItem.CreateSubmenu(options) {{{3
"make a new submenu and add it to global list
function! s:MenuItem.CreateSubmenu(options)
    let standard_options = { 'callback': -1 }
    let options = extend(a:options, standard_options, "force")

    return s:MenuItem.Create(options)
endfunction

"FUNCTION: MenuItem.enabled() {{{3
"return 1 if this menu item should be displayed
"
"delegates off to the isActiveCallback, and defaults to 1 if no callback was
"specified
function! s:MenuItem.enabled()
    if self.isActiveCallback != -1
        return {self.isActiveCallback}()
    endif
    return 1
endfunction

"FUNCTION: MenuItem.execute() {{{3
"perform the action behind this menu item, if this menuitem has children then
"display a new menu for them, otherwise deletegate off to the menuitem's
"callback
function! s:MenuItem.execute()
    if len(self.children)
        let mc = s:MenuController.New(self.children)
        call mc.showMenu()
    else
        if self.callback != -1
            call {self.callback}()
        endif
    endif
endfunction

"FUNCTION: MenuItem.isSeparator() {{{3
"return 1 if this menuitem is a separator
function! s:MenuItem.isSeparator()
    return self.callback == -1 && self.children == []
endfunction

"FUNCTION: MenuItem.isSubmenu() {{{3
"return 1 if this menuitem is a submenu
function! s:MenuItem.isSubmenu()
    return self.callback == -1 && !empty(self.children)
endfunction

"CLASS: TreeFileNode {{{2
"This class is the parent of the TreeDirNode class and constitures the
"'Component' part of the composite design pattern between the treenode
"classes.
"============================================================
let s:TreeFileNode = {}
"FUNCTION: TreeFileNode.activate(forceKeepWinOpen) {{{3
function! s:TreeFileNode.activate(forceKeepWinOpen)
    call self.open()
    if !a:forceKeepWinOpen
        call s:closeTreeIfQuitOnOpen()
    end
endfunction
"FUNCTION: TreeFileNode.bookmark(name) {{{3
"bookmark this node with a:name
function! s:TreeFileNode.bookmark(name)
    try
        let oldMarkedNode = s:Bookmark.GetNodeForName(a:name, 1)
        call oldMarkedNode.path.cacheDisplayString()
    catch /^NERDTree.BookmarkNotFoundError/
    endtry

    call s:Bookmark.AddBookmark(a:name, self.path)
    call self.path.cacheDisplayString()
    call s:Bookmark.Write()
endfunction
"FUNCTION: TreeFileNode.cacheParent() {{{3
"initializes self.parent if it isnt already
function! s:TreeFileNode.cacheParent()
    if empty(self.parent)
        let parentPath = self.path.getParent()
        if parentPath.equals(self.path)
            throw "NERDTree.CannotCacheParentError: already at root"
        endif
        let self.parent = s:TreeFileNode.New(parentPath)
    endif
endfunction
"FUNCTION: TreeFileNode.compareNodes {{{3
"This is supposed to be a class level method but i cant figure out how to
"get func refs to work from a dict..
"
"A class level method that compares two nodes
"
"Args:
"n1, n2: the 2 nodes to compare
function! s:compareNodes(n1, n2)
    return a:n1.path.compareTo(a:n2.path)
endfunction

"FUNCTION: TreeFileNode.clearBoomarks() {{{3
function! s:TreeFileNode.clearBoomarks()
    for i in s:Bookmark.Bookmarks()
        if i.path.equals(self.path)
            call i.delete()
        end
    endfor
    call self.path.cacheDisplayString()
endfunction
"FUNCTION: TreeFileNode.copy(dest) {{{3
function! s:TreeFileNode.copy(dest)
    call self.path.copy(a:dest)
    let newPath = s:Path.New(a:dest)
    let parent = b:NERDTreeRoot.findNode(newPath.getParent())
    if !empty(parent)
        call parent.refresh()
    endif
    return parent.findNode(newPath)
endfunction

"FUNCTION: TreeFileNode.delete {{{3
"Removes this node from the tree and calls the Delete method for its path obj
function! s:TreeFileNode.delete()
    call self.path.delete()
    call self.parent.removeChild(self)
endfunction

"FUNCTION: TreeFileNode.displayString() {{{3
"
"Returns a string that specifies how the node should be represented as a
"string
"
"Return:
"a string that can be used in the view to represent this node
function! s:TreeFileNode.displayString()
    return self.path.displayString()
endfunction

"FUNCTION: TreeFileNode.equals(treenode) {{{3
"
"Compares this treenode to the input treenode and returns 1 if they are the
"same node.
"
"Use this method instead of ==  because sometimes when the treenodes contain
"many children, vim seg faults when doing ==
"
"Args:
"treenode: the other treenode to compare to
function! s:TreeFileNode.equals(treenode)
    return self.path.str() ==# a:treenode.path.str()
endfunction

"FUNCTION: TreeFileNode.findNode(path) {{{3
"Returns self if this node.path.Equals the given path.
"Returns {} if not equal.
"
"Args:
"path: the path object to compare against
function! s:TreeFileNode.findNode(path)
    if a:path.equals(self.path)
        return self
    endif
    return {}
endfunction
"FUNCTION: TreeFileNode.findOpenDirSiblingWithVisibleChildren(direction) {{{3
"
"Finds the next sibling for this node in the indicated direction. This sibling
"must be a directory and may/may not have children as specified.
"
"Args:
"direction: 0 if you want to find the previous sibling, 1 for the next sibling
"
"Return:
"a treenode object or {} if no appropriate sibling could be found
function! s:TreeFileNode.findOpenDirSiblingWithVisibleChildren(direction)
    "if we have no parent then we can have no siblings
    if self.parent != {}
        let nextSibling = self.findSibling(a:direction)

        while nextSibling != {}
            if nextSibling.path.isDirectory && nextSibling.hasVisibleChildren() && nextSibling.isOpen
                return nextSibling
            endif
            let nextSibling = nextSibling.findSibling(a:direction)
        endwhile
    endif

    return {}
endfunction
"FUNCTION: TreeFileNode.findSibling(direction) {{{3
"
"Finds the next sibling for this node in the indicated direction
"
"Args:
"direction: 0 if you want to find the previous sibling, 1 for the next sibling
"
"Return:
"a treenode object or {} if no sibling could be found
function! s:TreeFileNode.findSibling(direction)
    "if we have no parent then we can have no siblings
    if self.parent != {}

        "get the index of this node in its parents children
        let siblingIndx = self.parent.getChildIndex(self.path)

        if siblingIndx != -1
            "move a long to the next potential sibling node
            let siblingIndx = a:direction ==# 1 ? siblingIndx+1 : siblingIndx-1

            "keep moving along to the next sibling till we find one that is valid
            let numSiblings = self.parent.getChildCount()
            while siblingIndx >= 0 && siblingIndx < numSiblings

                "if the next node is not an ignored node (i.e. wont show up in the
                "view) then return it
                if self.parent.children[siblingIndx].path.ignore() ==# 0
                    return self.parent.children[siblingIndx]
                endif

                "go to next node
                let siblingIndx = a:direction ==# 1 ? siblingIndx+1 : siblingIndx-1
            endwhile
        endif
    endif

    return {}
endfunction

"FUNCTION: TreeFileNode.getLineNum(){{{3
"returns the line number this node is rendered on, or -1 if it isnt rendered
function! s:TreeFileNode.getLineNum()
    "if the node is the root then return the root line no.
    if self.isRoot()
        return s:TreeFileNode.GetRootLineNum()
    endif

    let totalLines = line("$")

    "the path components we have matched so far
    let pathcomponents = [substitute(b:NERDTreeRoot.path.str({'format': 'UI'}), '/ *$', '', '')]
    "the index of the component we are searching for
    let curPathComponent = 1

    let fullpath = self.path.str({'format': 'UI'})


    let lnum = s:TreeFileNode.GetRootLineNum()
    while lnum > 0
        let lnum = lnum + 1
        "have we reached the bottom of the tree?
        if lnum ==# totalLines+1
            return -1
        endif

        let curLine = getline(lnum)

        let indent = s:indentLevelFor(curLine)
        if indent ==# curPathComponent
            let curLine = s:stripMarkupFromLine(curLine, 1)

            let curPath =  join(pathcomponents, '/') . '/' . curLine
            if stridx(fullpath, curPath, 0) ==# 0
                if fullpath ==# curPath || strpart(fullpath, len(curPath)-1,1) ==# '/'
                    let curLine = substitute(curLine, '/ *$', '', '')
                    call add(pathcomponents, curLine)
                    let curPathComponent = curPathComponent + 1

                    if fullpath ==# curPath
                        return lnum
                    endif
                endif
            endif
        endif
    endwhile
    return -1
endfunction

"FUNCTION: TreeFileNode.GetRootForTab(){{{3
"get the root node for this tab
function! s:TreeFileNode.GetRootForTab()
    if s:treeExistsForTab()
        return getbufvar(t:NERDTreeBufName, 'NERDTreeRoot')
    end
    return {}
endfunction
"FUNCTION: TreeFileNode.GetRootLineNum(){{{3
"gets the line number of the root node
function! s:TreeFileNode.GetRootLineNum()
    let rootLine = 1
    while getline(rootLine) !~ '^\(/\|<\)'
        let rootLine = rootLine + 1
    endwhile
    return rootLine
endfunction

"FUNCTION: TreeFileNode.GetSelected() {{{3
"gets the treenode that the cursor is currently over
function! s:TreeFileNode.GetSelected()
    try
        let path = s:getPath(line("."))
        if path ==# {}
            return {}
        endif
        return b:NERDTreeRoot.findNode(path)
    catch /NERDTree/
        return {}
    endtry
endfunction
"FUNCTION: TreeFileNode.isVisible() {{{3
"returns 1 if this node should be visible according to the tree filters and
"hidden file filters (and their on/off status)
function! s:TreeFileNode.isVisible()
    return !self.path.ignore()
endfunction
"FUNCTION: TreeFileNode.isRoot() {{{3
"returns 1 if this node is b:NERDTreeRoot
function! s:TreeFileNode.isRoot()
    if !s:treeExistsForBuf()
        throw "NERDTree.NoTreeError: No tree exists for the current buffer"
    endif

    return self.equals(b:NERDTreeRoot)
endfunction

"FUNCTION: TreeFileNode.makeRoot() {{{3
"Make this node the root of the tree
function! s:TreeFileNode.makeRoot()
    if self.path.isDirectory
        let b:NERDTreeRoot = self
    else
        call self.cacheParent()
        let b:NERDTreeRoot = self.parent
    endif

    call b:NERDTreeRoot.open()

    "change dir to the dir of the new root if instructed to
    if g:NERDTreeChDirMode ==# 2
        exec "cd " . b:NERDTreeRoot.path.str({'format': 'Edit'})
    endif
endfunction
"FUNCTION: TreeFileNode.New(path) {{{3
"Returns a new TreeNode object with the given path and parent
"
"Args:
"path: a path object representing the full filesystem path to the file/dir that the node represents
function! s:TreeFileNode.New(path)
    if a:path.isDirectory
        return s:TreeDirNode.New(a:path)
    else
        let newTreeNode = copy(self)
        let newTreeNode.path = a:path
        let newTreeNode.parent = {}
        return newTreeNode
    endif
endfunction

"FUNCTION: TreeFileNode.open() {{{3
"Open the file represented by the given node in the current window, splitting
"the window if needed
"
"ARGS:
"treenode: file node to open
function! s:TreeFileNode.open()
    if b:NERDTreeType ==# "secondary"
        exec 'edit ' . self.path.str({'format': 'Edit'})
        return
    endif

    "if the file is already open in this tab then just stick the cursor in it
    let winnr = bufwinnr('^' . self.path.str() . '$')
    if winnr != -1
        call s:exec(winnr . "wincmd w")

    else
        if !s:isWindowUsable(winnr("#")) && s:firstUsableWindow() ==# -1
            call self.openSplit()
        else
            try
                if !s:isWindowUsable(winnr("#"))
                    call s:exec(s:firstUsableWindow() . "wincmd w")
                else
                    call s:exec('wincmd p')
                endif
                exec ("edit " . self.path.str({'format': 'Edit'}))
            catch /^Vim\%((\a\+)\)\=:E37/
                call s:putCursorInTreeWin()
                throw "NERDTree.FileAlreadyOpenAndModifiedError: ". self.path.str() ." is already open and modified."
            catch /^Vim\%((\a\+)\)\=:/
                echo v:exception
            endtry
        endif
    endif
endfunction
"FUNCTION: TreeFileNode.openSplit() {{{3
"Open this node in a new window
function! s:TreeFileNode.openSplit()

    if b:NERDTreeType ==# "secondary"
        exec "split " . self.path.str({'format': 'Edit'})
        return
    endif

    " Save the user's settings for splitbelow and splitright
    let savesplitbelow=&splitbelow
    let savesplitright=&splitright

    " 'there' will be set to a command to move from the split window
    " back to the explorer window
    "
    " 'back' will be set to a command to move from the explorer window
    " back to the newly split window
    "
    " 'right' and 'below' will be set to the settings needed for
    " splitbelow and splitright IF the explorer is the only window.
    "
    let there= g:NERDTreeWinPos ==# "left" ? "wincmd h" : "wincmd l"
    let back = g:NERDTreeWinPos ==# "left" ? "wincmd l" : "wincmd h"
    let right= g:NERDTreeWinPos ==# "left"
    let below=0

    " Attempt to go to adjacent window
    call s:exec(back)

    let onlyOneWin = (winnr("$") ==# 1)

    " If no adjacent window, set splitright and splitbelow appropriately
    if onlyOneWin
        let &splitright=right
        let &splitbelow=below
    else
        " found adjacent window - invert split direction
        let &splitright=!right
        let &splitbelow=!below
    endif

    let splitMode = onlyOneWin ? "vertical" : ""

    " Open the new window
    try
        exec(splitMode." sp " . self.path.str({'format': 'Edit'}))
    catch /^Vim\%((\a\+)\)\=:E37/
        call s:putCursorInTreeWin()
        throw "NERDTree.FileAlreadyOpenAndModifiedError: ". self.path.str() ." is already open and modified."
    catch /^Vim\%((\a\+)\)\=:/
        "do nothing
    endtry

    "resize the tree window if no other window was open before
    if onlyOneWin
        let size = exists("b:NERDTreeOldWindowSize") ? b:NERDTreeOldWindowSize : g:NERDTreeWinSize
        call s:exec(there)
        exec("silent ". splitMode ." resize ". size)
        call s:exec('wincmd p')
    endif

    " Restore splitmode settings
    let &splitbelow=savesplitbelow
    let &splitright=savesplitright
endfunction
"FUNCTION: TreeFileNode.openVSplit() {{{3
"Open this node in a new vertical window
function! s:TreeFileNode.openVSplit()
    if b:NERDTreeType ==# "secondary"
        exec "vnew " . self.path.str({'format': 'Edit'})
        return
    endif

    let winwidth = winwidth(".")
    if winnr("$")==#1
        let winwidth = g:NERDTreeWinSize
    endif

    call s:exec("wincmd p")
    exec "vnew " . self.path.str({'format': 'Edit'})

    "resize the nerd tree back to the original size
    call s:putCursorInTreeWin()
    exec("silent vertical resize ". winwidth)
    call s:exec('wincmd p')
endfunction
"FUNCTION: TreeFileNode.openInNewTab(options) {{{3
function! s:TreeFileNode.openInNewTab(options)
    let currentTab = tabpagenr()

    if !has_key(a:options, 'keepTreeOpen')
        call s:closeTreeIfQuitOnOpen()
    endif

    exec "tabedit " . self.path.str({'format': 'Edit'})

    if has_key(a:options, 'stayInCurrentTab') && a:options['stayInCurrentTab']
        exec "tabnext " . currentTab
    endif

endfunction
"FUNCTION: TreeFileNode.putCursorHere(isJump, recurseUpward){{{3
"Places the cursor on the line number this node is rendered on
"
"Args:
"isJump: 1 if this cursor movement should be counted as a jump by vim
"recurseUpward: try to put the cursor on the parent if the this node isnt
"visible
function! s:TreeFileNode.putCursorHere(isJump, recurseUpward)
    let ln = self.getLineNum()
    if ln != -1
        if a:isJump
            mark '
        endif
        call cursor(ln, col("."))
    else
        if a:recurseUpward
            let node = self
            while node != {} && node.getLineNum() ==# -1
                let node = node.parent
                call node.open()
            endwhile
            call s:renderView()
            call node.putCursorHere(a:isJump, 0)
        endif
    endif
endfunction

"FUNCTION: TreeFileNode.refresh() {{{3
function! s:TreeFileNode.refresh()
    call self.path.refresh()
endfunction
"FUNCTION: TreeFileNode.rename() {{{3
"Calls the rename method for this nodes path obj
function! s:TreeFileNode.rename(newName)
    let newName = substitute(a:newName, '\(\\\|\/\)$', '', '')
    call self.path.rename(newName)
    call self.parent.removeChild(self)

    let parentPath = self.path.getParent()
    let newParent = b:NERDTreeRoot.findNode(parentPath)

    if newParent != {}
        call newParent.createChild(self.path, 1)
        call newParent.refresh()
    endif
endfunction
"FUNCTION: TreeFileNode.renderToString {{{3
"returns a string representation for this tree to be rendered in the view
function! s:TreeFileNode.renderToString()
    return self._renderToString(0, 0, [], self.getChildCount() ==# 1)
endfunction


"Args:
"depth: the current depth in the tree for this call
"drawText: 1 if we should actually draw the line for this node (if 0 then the
"child nodes are rendered only)
"vertMap: a binary array that indicates whether a vertical bar should be draw
"for each depth in the tree
"isLastChild:true if this curNode is the last child of its parent
function! s:TreeFileNode._renderToString(depth, drawText, vertMap, isLastChild)
    let output = ""
    if a:drawText ==# 1

        let treeParts = ''

        "get all the leading spaces and vertical tree parts for this line
        if a:depth > 1
            for j in a:vertMap[0:-2]
                if j ==# 1
                    let treeParts = treeParts . '| '
                else
                    let treeParts = treeParts . '  '
                endif
            endfor
        endif

        "get the last vertical tree part for this line which will be different
        "if this node is the last child of its parent
        if a:isLastChild
            let treeParts = treeParts . '`'
        else
            let treeParts = treeParts . '|'
        endif


        "smack the appropriate dir/file symbol on the line before the file/dir
        "name itself
        if self.path.isDirectory
            if self.isOpen
                let treeParts = treeParts . '~'
            else
                let treeParts = treeParts . '+'
            endif
        else
            let treeParts = treeParts . '-'
        endif
        let line = treeParts . self.displayString()

        let output = output . line . "\n"
    endif

    "if the node is an open dir, draw its children
    if self.path.isDirectory ==# 1 && self.isOpen ==# 1

        let childNodesToDraw = self.getVisibleChildren()
        if len(childNodesToDraw) > 0

            "draw all the nodes children except the last
            let lastIndx = len(childNodesToDraw)-1
            if lastIndx > 0
                for i in childNodesToDraw[0:lastIndx-1]
                    let output = output . i._renderToString(a:depth + 1, 1, add(copy(a:vertMap), 1), 0)
                endfor
            endif

            "draw the last child, indicating that it IS the last
            let output = output . childNodesToDraw[lastIndx]._renderToString(a:depth + 1, 1, add(copy(a:vertMap), 0), 1)
        endif
    endif

    return output
endfunction
"CLASS: TreeDirNode {{{2
"This class is a child of the TreeFileNode class and constitutes the
"'Composite' part of the composite design pattern between the treenode
"classes.
"============================================================
let s:TreeDirNode = copy(s:TreeFileNode)
"FUNCTION: TreeDirNode.AbsoluteTreeRoot(){{{3
"class method that returns the highest cached ancestor of the current root
function! s:TreeDirNode.AbsoluteTreeRoot()
    let currentNode = b:NERDTreeRoot
    while currentNode.parent != {}
        let currentNode = currentNode.parent
    endwhile
    return currentNode
endfunction
"FUNCTION: TreeDirNode.activate(forceKeepWinOpen) {{{3
unlet s:TreeDirNode.activate
function! s:TreeDirNode.activate(forceKeepWinOpen)
    call self.toggleOpen()
    call s:renderView()
    call self.putCursorHere(0, 0)
endfunction
"FUNCTION: TreeDirNode.addChild(treenode, inOrder) {{{3
"Adds the given treenode to the list of children for this node
"
"Args:
"-treenode: the node to add
"-inOrder: 1 if the new node should be inserted in sorted order
function! s:TreeDirNode.addChild(treenode, inOrder)
    call add(self.children, a:treenode)
    let a:treenode.parent = self

    if a:inOrder
        call self.sortChildren()
    endif
endfunction

"FUNCTION: TreeDirNode.close() {{{3
"Closes this directory
function! s:TreeDirNode.close()
    let self.isOpen = 0
endfunction

"FUNCTION: TreeDirNode.closeChildren() {{{3
"Closes all the child dir nodes of this node
function! s:TreeDirNode.closeChildren()
    for i in self.children
        if i.path.isDirectory
            call i.close()
            call i.closeChildren()
        endif
    endfor
endfunction

"FUNCTION: TreeDirNode.createChild(path, inOrder) {{{3
"Instantiates a new child node for this node with the given path. The new
"nodes parent is set to this node.
"
"Args:
"path: a Path object that this node will represent/contain
"inOrder: 1 if the new node should be inserted in sorted order
"
"Returns:
"the newly created node
function! s:TreeDirNode.createChild(path, inOrder)
    let newTreeNode = s:TreeFileNode.New(a:path)
    call self.addChild(newTreeNode, a:inOrder)
    return newTreeNode
endfunction

"FUNCTION: TreeDirNode.findNode(path) {{{3
"Will find one of the children (recursively) that has the given path
"
"Args:
"path: a path object
unlet s:TreeDirNode.findNode
function! s:TreeDirNode.findNode(path)
    if a:path.equals(self.path)
        return self
    endif
    if stridx(a:path.str(), self.path.str(), 0) ==# -1
        return {}
    endif

    if self.path.isDirectory
        for i in self.children
            let retVal = i.findNode(a:path)
            if retVal != {}
                return retVal
            endif
        endfor
    endif
    return {}
endfunction
"FUNCTION: TreeDirNode.getChildCount() {{{3
"Returns the number of children this node has
function! s:TreeDirNode.getChildCount()
    return len(self.children)
endfunction

"FUNCTION: TreeDirNode.getChild(path) {{{3
"Returns child node of this node that has the given path or {} if no such node
"exists.
"
"This function doesnt not recurse into child dir nodes
"
"Args:
"path: a path object
function! s:TreeDirNode.getChild(path)
    if stridx(a:path.str(), self.path.str(), 0) ==# -1
        return {}
    endif

    let index = self.getChildIndex(a:path)
    if index ==# -1
        return {}
    else
        return self.children[index]
    endif

endfunction

"FUNCTION: TreeDirNode.getChildByIndex(indx, visible) {{{3
"returns the child at the given index
"Args:
"indx: the index to get the child from
"visible: 1 if only the visible children array should be used, 0 if all the
"children should be searched.
function! s:TreeDirNode.getChildByIndex(indx, visible)
    let array_to_search = a:visible? self.getVisibleChildren() : self.children
    if a:indx > len(array_to_search)
        throw "NERDTree.InvalidArgumentsError: Index is out of bounds."
    endif
    return array_to_search[a:indx]
endfunction

"FUNCTION: TreeDirNode.getChildIndex(path) {{{3
"Returns the index of the child node of this node that has the given path or
"-1 if no such node exists.
"
"This function doesnt not recurse into child dir nodes
"
"Args:
"path: a path object
function! s:TreeDirNode.getChildIndex(path)
    if stridx(a:path.str(), self.path.str(), 0) ==# -1
        return -1
    endif

    "do a binary search for the child
    let a = 0
    let z = self.getChildCount()
    while a < z
        let mid = (a+z)/2
        let diff = a:path.compareTo(self.children[mid].path)

        if diff ==# -1
            let z = mid
        elseif diff ==# 1
            let a = mid+1
        else
            return mid
        endif
    endwhile
    return -1
endfunction

"FUNCTION: TreeDirNode.GetSelected() {{{3
"Returns the current node if it is a dir node, or else returns the current
"nodes parent
unlet s:TreeDirNode.GetSelected
function! s:TreeDirNode.GetSelected()
    let currentDir = s:TreeFileNode.GetSelected()
    if currentDir != {} && !currentDir.isRoot()
        if currentDir.path.isDirectory ==# 0
            let currentDir = currentDir.parent
        endif
    endif
    return currentDir
endfunction
"FUNCTION: TreeDirNode.getVisibleChildCount() {{{3
"Returns the number of visible children this node has
function! s:TreeDirNode.getVisibleChildCount()
    return len(self.getVisibleChildren())
endfunction

"FUNCTION: TreeDirNode.getVisibleChildren() {{{3
"Returns a list of children to display for this node, in the correct order
"
"Return:
"an array of treenodes
function! s:TreeDirNode.getVisibleChildren()
    let toReturn = []
    for i in self.children
        if i.path.ignore() ==# 0
            call add(toReturn, i)
        endif
    endfor
    return toReturn
endfunction

"FUNCTION: TreeDirNode.hasVisibleChildren() {{{3
"returns 1 if this node has any childre, 0 otherwise..
function! s:TreeDirNode.hasVisibleChildren()
    return self.getVisibleChildCount() != 0
endfunction

"FUNCTION: TreeDirNode._initChildren() {{{3
"Removes all childen from this node and re-reads them
"
"Args:
"silent: 1 if the function should not echo any "please wait" messages for
"large directories
"
"Return: the number of child nodes read
function! s:TreeDirNode._initChildren(silent)
    "remove all the current child nodes
    let self.children = []

    "get an array of all the files in the nodes dir
    let dir = self.path
    let globDir = dir.str({'format': 'Glob'})
    let filesStr = globpath(globDir, '*') . "\n" . globpath(globDir, '.*')
    let files = split(filesStr, "\n")

    if !a:silent && len(files) > g:NERDTreeNotificationThreshold
        call s:echo("Please wait, caching a large dir ...")
    endif

    let invalidFilesFound = 0
    for i in files

        "filter out the .. and . directories
        "Note: we must match .. AND ../ cos sometimes the globpath returns
        "../ for path with strange chars (eg $)
        if i !~ '\/\.\.\/\?$' && i !~ '\/\.\/\?$'

            "put the next file in a new node and attach it
            try
                let path = s:Path.New(i)
                call self.createChild(path, 0)
            catch /^NERDTree.\(InvalidArguments\|InvalidFiletype\)Error/
                let invalidFilesFound += 1
            endtry
        endif
    endfor

    call self.sortChildren()

    if !a:silent && len(files) > g:NERDTreeNotificationThreshold
        call s:echo("Please wait, caching a large dir ... DONE (". self.getChildCount() ." nodes cached).")
    endif

    if invalidFilesFound
        call s:echoWarning(invalidFilesFound . " file(s) could not be loaded into the NERD tree")
    endif
    return self.getChildCount()
endfunction
"FUNCTION: TreeDirNode.New(path) {{{3
"Returns a new TreeNode object with the given path and parent
"
"Args:
"path: a path object representing the full filesystem path to the file/dir that the node represents
unlet s:TreeDirNode.New
function! s:TreeDirNode.New(path)
    if a:path.isDirectory != 1
        throw "NERDTree.InvalidArgumentsError: A TreeDirNode object must be instantiated with a directory Path object."
    endif

    let newTreeNode = copy(self)
    let newTreeNode.path = a:path

    let newTreeNode.isOpen = 0
    let newTreeNode.children = []

    let newTreeNode.parent = {}

    return newTreeNode
endfunction
"FUNCTION: TreeDirNode.open() {{{3
"Reads in all this nodes children
"
"Return: the number of child nodes read
unlet s:TreeDirNode.open
function! s:TreeDirNode.open()
    let self.isOpen = 1
    if self.children ==# []
        return self._initChildren(0)
    else
        return 0
    endif
endfunction

" FUNCTION: TreeDirNode.openExplorer() {{{3
" opens an explorer window for this node in the previous window (could be a
" nerd tree or a netrw)
function! s:TreeDirNode.openExplorer()
    let oldwin = winnr()
    call s:exec('wincmd p')
    if oldwin ==# winnr() || (&modified && s:bufInWindows(winbufnr(winnr())) < 2)
        call s:exec('wincmd p')
        call self.openSplit()
    else
        exec ("silent edit " . self.path.str({'format': 'Edit'}))
    endif
endfunction
"FUNCTION: TreeDirNode.openInNewTab(options) {{{3
unlet s:TreeDirNode.openInNewTab
function! s:TreeDirNode.openInNewTab(options)
    let currentTab = tabpagenr()

    if !has_key(a:options, 'keepTreeOpen') || !a:options['keepTreeOpen']
        call s:closeTreeIfQuitOnOpen()
    endif

    tabnew
    call s:initNerdTree(self.path.str())

    if has_key(a:options, 'stayInCurrentTab') && a:options['stayInCurrentTab']
        exec "tabnext " . currentTab
    endif
endfunction
"FUNCTION: TreeDirNode.openRecursively() {{{3
"Opens this treenode and all of its children whose paths arent 'ignored'
"because of the file filters.
"
"This method is actually a wrapper for the OpenRecursively2 method which does
"the work.
function! s:TreeDirNode.openRecursively()
    call self._openRecursively2(1)
endfunction

"FUNCTION: TreeDirNode._openRecursively2() {{{3
"Opens this all children of this treenode recursively if either:
"   *they arent filtered by file filters
"   *a:forceOpen is 1
"
"Args:
"forceOpen: 1 if this node should be opened regardless of file filters
function! s:TreeDirNode._openRecursively2(forceOpen)
    if self.path.ignore() ==# 0 || a:forceOpen
        let self.isOpen = 1
        if self.children ==# []
            call self._initChildren(1)
        endif

        for i in self.children
            if i.path.isDirectory ==# 1
                call i._openRecursively2(0)
            endif
        endfor
    endif
endfunction

"FUNCTION: TreeDirNode.refresh() {{{3
unlet s:TreeDirNode.refresh
function! s:TreeDirNode.refresh()
    call self.path.refresh()

    "if this node was ever opened, refresh its children
    if self.isOpen || !empty(self.children)
        "go thru all the files/dirs under this node
        let newChildNodes = []
        let invalidFilesFound = 0
        let dir = self.path
        let globDir = dir.str({'format': 'Glob'})
        let filesStr = globpath(globDir, '*') . "\n" . globpath(globDir, '.*')
        let files = split(filesStr, "\n")
        for i in files
            "filter out the .. and . directories
            "Note: we must match .. AND ../ cos sometimes the globpath returns
            "../ for path with strange chars (eg $)
            if i !~ '\/\.\.\/\?$' && i !~ '\/\.\/\?$'

                try
                    "create a new path and see if it exists in this nodes children
                    let path = s:Path.New(i)
                    let newNode = self.getChild(path)
                    if newNode != {}
                        call newNode.refresh()
                        call add(newChildNodes, newNode)

                    "the node doesnt exist so create it
                    else
                        let newNode = s:TreeFileNode.New(path)
                        let newNode.parent = self
                        call add(newChildNodes, newNode)
                    endif


                catch /^NERDTree.InvalidArgumentsError/
                    let invalidFilesFound = 1
                endtry
            endif
        endfor

        "swap this nodes children out for the children we just read/refreshed
        let self.children = newChildNodes
        call self.sortChildren()

        if invalidFilesFound
            call s:echoWarning("some files could not be loaded into the NERD tree")
        endif
    endif
endfunction

"FUNCTION: TreeDirNode.reveal(path) {{{3
"reveal the given path, i.e. cache and open all treenodes needed to display it
"in the UI
function! s:TreeDirNode.reveal(path)
    if !a:path.isUnder(self.path)
        throw "NERDTree.InvalidArgumentsError: " . a:path.str() . " should be under " . self.path.str()
    endif

    call self.open()

    if self.path.equals(a:path.getParent())
        let n = self.findNode(a:path)
        call s:renderView()
        call n.putCursorHere(1,0)
        return
    endif

    let p = a:path
    while !p.getParent().equals(self.path)
        let p = p.getParent()
    endwhile

    let n = self.findNode(p)
    call n.reveal(a:path)
endfunction
"FUNCTION: TreeDirNode.removeChild(treenode) {{{3
"
"Removes the given treenode from this nodes set of children
"
"Args:
"treenode: the node to remove
"
"Throws a NERDTree.ChildNotFoundError if the given treenode is not found
function! s:TreeDirNode.removeChild(treenode)
    for i in range(0, self.getChildCount()-1)
        if self.children[i].equals(a:treenode)
            call remove(self.children, i)
            return
        endif
    endfor

    throw "NERDTree.ChildNotFoundError: child node was not found"
endfunction

"FUNCTION: TreeDirNode.sortChildren() {{{3
"
"Sorts the children of this node according to alphabetical order and the
"directory priority.
"
function! s:TreeDirNode.sortChildren()
    let CompareFunc = function("s:compareNodes")
    call sort(self.children, CompareFunc)
endfunction

"FUNCTION: TreeDirNode.toggleOpen() {{{3
"Opens this directory if it is closed and vice versa
function! s:TreeDirNode.toggleOpen()
    if self.isOpen ==# 1
        call self.close()
    else
        call self.open()
    endif
endfunction

"FUNCTION: TreeDirNode.transplantChild(newNode) {{{3
"Replaces the child of this with the given node (where the child node's full
"path matches a:newNode's fullpath). The search for the matching node is
"non-recursive
"
"Arg:
"newNode: the node to graft into the tree
function! s:TreeDirNode.transplantChild(newNode)
    for i in range(0, self.getChildCount()-1)
        if self.children[i].equals(a:newNode)
            let self.children[i] = a:newNode
            let a:newNode.parent = self
            break
        endif
    endfor
endfunction
"============================================================
"CLASS: Path {{{2
"============================================================
let s:Path = {}
"FUNCTION: Path.AbsolutePathFor(str) {{{3
function! s:Path.AbsolutePathFor(str)
    let prependCWD = 0
    if s:running_windows
        let prependCWD = a:str !~ '^.:\(\\\|\/\)'
    else
        let prependCWD = a:str !~ '^/'
    endif

    let toReturn = a:str
    if prependCWD
        let toReturn = getcwd() . s:Path.Slash() . a:str
    endif

    return toReturn
endfunction
"FUNCTION: Path.bookmarkNames() {{{3
function! s:Path.bookmarkNames()
    if !exists("self._bookmarkNames")
        call self.cacheDisplayString()
    endif
    return self._bookmarkNames
endfunction
"FUNCTION: Path.cacheDisplayString() {{{3
function! s:Path.cacheDisplayString()
    let self.cachedDisplayString = self.getLastPathComponent(1)

    if self.isExecutable
        let self.cachedDisplayString = self.cachedDisplayString . '*'
    endif

    let self._bookmarkNames = []
    for i in s:Bookmark.Bookmarks()
        if i.path.equals(self)
            call add(self._bookmarkNames, i.name)
        endif
    endfor
    if !empty(self._bookmarkNames)
        let self.cachedDisplayString .= ' {' . join(self._bookmarkNames) . '}'
    endif

    if self.isSymLink
        let self.cachedDisplayString .=  ' -> ' . self.symLinkDest
    endif

    if self.isReadOnly
        let self.cachedDisplayString .=  ' [RO]'
    endif
endfunction
"FUNCTION: Path.changeToDir() {{{3
function! s:Path.changeToDir()
    let dir = self.str({'format': 'Cd'})
    if self.isDirectory ==# 0
        let dir = self.getParent().str({'format': 'Cd'})
    endif

    try
        execute "cd " . dir
        call s:echo("CWD is now: " . getcwd())
    catch
        throw "NERDTree.PathChangeError: cannot change CWD to " . dir
    endtry
endfunction

"FUNCTION: Path.compareTo() {{{3
"
"Compares this Path to the given path and returns 0 if they are equal, -1 if
"this Path is "less than" the given path, or 1 if it is "greater".
"
"Args:
"path: the path object to compare this to
"
"Return:
"1, -1 or 0
function! s:Path.compareTo(path)
    let thisPath = self.getLastPathComponent(1)
    let thatPath = a:path.getLastPathComponent(1)

    "if the paths are the same then clearly we return 0
    if thisPath ==# thatPath
        return 0
    endif

    let thisSS = self.getSortOrderIndex()
    let thatSS = a:path.getSortOrderIndex()

    "compare the sort sequences, if they are different then the return
    "value is easy
    if thisSS < thatSS
        return -1
    elseif thisSS > thatSS
        return 1
    else
        "if the sort sequences are the same then compare the paths
        "alphabetically
        let pathCompare = g:NERDTreeCaseSensitiveSort ? thisPath <# thatPath : thisPath <? thatPath
        if pathCompare
            return -1
        else
            return 1
        endif
    endif
endfunction

"FUNCTION: Path.Create(fullpath) {{{3
"
"Factory method.
"
"Creates a path object with the given path. The path is also created on the
"filesystem. If the path already exists, a NERDTree.Path.Exists exception is
"thrown. If any other errors occur, a NERDTree.Path exception is thrown.
"
"Args:
"fullpath: the full filesystem path to the file/dir to create
function! s:Path.Create(fullpath)
    "bail if the a:fullpath already exists
    if isdirectory(a:fullpath) || filereadable(a:fullpath)
        throw "NERDTree.CreatePathError: Directory Exists: '" . a:fullpath . "'"
    endif

    try

        "if it ends with a slash, assume its a dir create it
        if a:fullpath =~ '\(\\\|\/\)$'
            "whack the trailing slash off the end if it exists
            let fullpath = substitute(a:fullpath, '\(\\\|\/\)$', '', '')

            call mkdir(fullpath, 'p')

        "assume its a file and create
        else
            call writefile([], a:fullpath)
        endif
    catch
        throw "NERDTree.CreatePathError: Could not create path: '" . a:fullpath . "'"
    endtry

    return s:Path.New(a:fullpath)
endfunction

"FUNCTION: Path.copy(dest) {{{3
"
"Copies the file/dir represented by this Path to the given location
"
"Args:
"dest: the location to copy this dir/file to
function! s:Path.copy(dest)
    if !s:Path.CopyingSupported()
        throw "NERDTree.CopyingNotSupportedError: Copying is not supported on this OS"
    endif

    let dest = s:Path.WinToUnixPath(a:dest)

    let cmd = g:NERDTreeCopyCmd . " " . self.str() . " " . dest
    let success = system(cmd)
    if success != 0
        throw "NERDTree.CopyError: Could not copy ''". self.str() ."'' to: '" . a:dest . "'"
    endif
endfunction

"FUNCTION: Path.CopyingSupported() {{{3
"
"returns 1 if copying is supported for this OS
function! s:Path.CopyingSupported()
    return exists('g:NERDTreeCopyCmd')
endfunction


"FUNCTION: Path.copyingWillOverwrite(dest) {{{3
"
"returns 1 if copy this path to the given location will cause files to
"overwritten
"
"Args:
"dest: the location this path will be copied to
function! s:Path.copyingWillOverwrite(dest)
    if filereadable(a:dest)
        return 1
    endif

    if isdirectory(a:dest)
        let path = s:Path.JoinPathStrings(a:dest, self.getLastPathComponent(0))
        if filereadable(path)
            return 1
        endif
    endif
endfunction

"FUNCTION: Path.delete() {{{3
"
"Deletes the file represented by this path.
"Deletion of directories is not supported
"
"Throws NERDTree.Path.Deletion exceptions
function! s:Path.delete()
    if self.isDirectory

        let cmd = g:NERDTreeRemoveDirCmd . self.str({'escape': 1})
        let success = system(cmd)

        if v:shell_error != 0
            throw "NERDTree.PathDeletionError: Could not delete directory: '" . self.str() . "'"
        endif
    else
        let success = delete(self.str())
        if success != 0
            throw "NERDTree.PathDeletionError: Could not delete file: '" . self.str() . "'"
        endif
    endif

    "delete all bookmarks for this path
    for i in self.bookmarkNames()
        let bookmark = s:Bookmark.BookmarkFor(i)
        call bookmark.delete()
    endfor
endfunction

"FUNCTION: Path.displayString() {{{3
"
"Returns a string that specifies how the path should be represented as a
"string
function! s:Path.displayString()
    if self.cachedDisplayString ==# ""
        call self.cacheDisplayString()
    endif

    return self.cachedDisplayString
endfunction
"FUNCTION: Path.extractDriveLetter(fullpath) {{{3
"
"If running windows, cache the drive letter for this path
function! s:Path.extractDriveLetter(fullpath)
    if s:running_windows
        let self.drive = substitute(a:fullpath, '\(^[a-zA-Z]:\).*', '\1', '')
    else
        let self.drive = ''
    endif

endfunction
"FUNCTION: Path.exists() {{{3
"return 1 if this path points to a location that is readable or is a directory
function! s:Path.exists()
    let p = self.str()
    return filereadable(p) || isdirectory(p)
endfunction
"FUNCTION: Path.getDir() {{{3
"
"Returns this path if it is a directory, else this paths parent.
"
"Return:
"a Path object
function! s:Path.getDir()
    if self.isDirectory
        return self
    else
        return self.getParent()
    endif
endfunction
"FUNCTION: Path.getParent() {{{3
"
"Returns a new path object for this paths parent
"
"Return:
"a new Path object
function! s:Path.getParent()
    if s:running_windows
        let path = self.drive . '\' . join(self.pathSegments[0:-2], '\')
    else
        let path = '/'. join(self.pathSegments[0:-2], '/')
    endif

    return s:Path.New(path)
endfunction
"FUNCTION: Path.getLastPathComponent(dirSlash) {{{3
"
"Gets the last part of this path.
"
"Args:
"dirSlash: if 1 then a trailing slash will be added to the returned value for
"directory nodes.
function! s:Path.getLastPathComponent(dirSlash)
    if empty(self.pathSegments)
        return ''
    endif
    let toReturn = self.pathSegments[-1]
    if a:dirSlash && self.isDirectory
        let toReturn = toReturn . '/'
    endif
    return toReturn
endfunction

"FUNCTION: Path.getSortOrderIndex() {{{3
"returns the index of the pattern in g:NERDTreeSortOrder that this path matches
function! s:Path.getSortOrderIndex()
    let i = 0
    while i < len(g:NERDTreeSortOrder)
        if  self.getLastPathComponent(1) =~ g:NERDTreeSortOrder[i]
            return i
        endif
        let i = i + 1
    endwhile
    return s:NERDTreeSortStarIndex
endfunction

"FUNCTION: Path.ignore() {{{3
"returns true if this path should be ignored
function! s:Path.ignore()
    let lastPathComponent = self.getLastPathComponent(0)

    "filter out the user specified paths to ignore
    if b:NERDTreeIgnoreEnabled
        for i in g:NERDTreeIgnore
            if lastPathComponent =~ i
                return 1
            endif
        endfor
    endif

    "dont show hidden files unless instructed to
    if b:NERDTreeShowHidden ==# 0 && lastPathComponent =~ '^\.'
        return 1
    endif

    if b:NERDTreeShowFiles ==# 0 && self.isDirectory ==# 0
        return 1
    endif

    return 0
endfunction

"FUNCTION: Path.isUnder(path) {{{3
"return 1 if this path is somewhere under the given path in the filesystem.
"
"a:path should be a dir
function! s:Path.isUnder(path)
    if a:path.isDirectory == 0
        return 0
    endif

    let this = self.str()
    let that = a:path.str()
    return stridx(this, that . s:Path.Slash()) == 0
endfunction

"FUNCTION: Path.JoinPathStrings(...) {{{3
function! s:Path.JoinPathStrings(...)
    let components = []
    for i in a:000
        let components = extend(components, split(i, '/'))
    endfor
    return '/' . join(components, '/')
endfunction

"FUNCTION: Path.equals() {{{3
"
"Determines whether 2 path objects are "equal".
"They are equal if the paths they represent are the same
"
"Args:
"path: the other path obj to compare this with
function! s:Path.equals(path)
    return self.str() ==# a:path.str()
endfunction

"FUNCTION: Path.New() {{{3
"The Constructor for the Path object
function! s:Path.New(path)
    let newPath = copy(self)

    call newPath.readInfoFromDisk(s:Path.AbsolutePathFor(a:path))

    let newPath.cachedDisplayString = ""

    return newPath
endfunction

"FUNCTION: Path.Slash() {{{3
"return the slash to use for the current OS
function! s:Path.Slash()
    return s:running_windows ? '\' : '/'
endfunction

"FUNCTION: Path.readInfoFromDisk(fullpath) {{{3
"
"
"Throws NERDTree.Path.InvalidArguments exception.
function! s:Path.readInfoFromDisk(fullpath)
    call self.extractDriveLetter(a:fullpath)

    let fullpath = s:Path.WinToUnixPath(a:fullpath)

    if getftype(fullpath) ==# "fifo"
        throw "NERDTree.InvalidFiletypeError: Cant handle FIFO files: " . a:fullpath
    endif

    let self.pathSegments = split(fullpath, '/')

    let self.isReadOnly = 0
    if isdirectory(a:fullpath)
        let self.isDirectory = 1
    elseif filereadable(a:fullpath)
        let self.isDirectory = 0
        let self.isReadOnly = filewritable(a:fullpath) ==# 0
    else
        throw "NERDTree.InvalidArgumentsError: Invalid path = " . a:fullpath
    endif

    let self.isExecutable = 0
    if !self.isDirectory
        let self.isExecutable = getfperm(a:fullpath) =~ 'x'
    endif

    "grab the last part of the path (minus the trailing slash)
    let lastPathComponent = self.getLastPathComponent(0)

    "get the path to the new node with the parent dir fully resolved
    let hardPath = resolve(self.strTrunk()) . '/' . lastPathComponent

    "if  the last part of the path is a symlink then flag it as such
    let self.isSymLink = (resolve(hardPath) != hardPath)
    if self.isSymLink
        let self.symLinkDest = resolve(fullpath)

        "if the link is a dir then slap a / on the end of its dest
        if isdirectory(self.symLinkDest)

            "we always wanna treat MS windows shortcuts as files for
            "simplicity
            if hardPath !~ '\.lnk$'

                let self.symLinkDest = self.symLinkDest . '/'
            endif
        endif
    endif
endfunction

"FUNCTION: Path.refresh() {{{3
function! s:Path.refresh()
    call self.readInfoFromDisk(self.str())
    call self.cacheDisplayString()
endfunction

"FUNCTION: Path.rename() {{{3
"
"Renames this node on the filesystem
function! s:Path.rename(newPath)
    if a:newPath ==# ''
        throw "NERDTree.InvalidArgumentsError: Invalid newPath for renaming = ". a:newPath
    endif

    let success =  rename(self.str(), a:newPath)
    if success != 0
        throw "NERDTree.PathRenameError: Could not rename: '" . self.str() . "'" . 'to:' . a:newPath
    endif
    call self.readInfoFromDisk(a:newPath)

    for i in self.bookmarkNames()
        let b = s:Bookmark.BookmarkFor(i)
        call b.setPath(copy(self))
    endfor
    call s:Bookmark.Write()
endfunction

"FUNCTION: Path.str() {{{3
"
"Returns a string representation of this Path
"
"Takes an optional dictionary param to specify how the output should be
"formatted.
"
"The dict may have the following keys:
"  'format'
"  'escape'
"  'truncateTo'
"
"The 'format' key may have a value of:
"  'Cd' - a string to be used with the :cd command
"  'Edit' - a string to be used with :e :sp :new :tabedit etc
"  'UI' - a string used in the NERD tree UI
"
"The 'escape' key, if specified will cause the output to be escaped with
"shellescape()
"
"The 'truncateTo' key causes the resulting string to be truncated to the value
"'truncateTo' maps to. A '<' char will be prepended.
function! s:Path.str(...)
    let options = a:0 ? a:1 : {}
    let toReturn = ""

    if has_key(options, 'format')
        let format = options['format']
        if has_key(self, '_strFor' . format)
            exec 'let toReturn = self._strFor' . format . '()'
        else
            raise 'NERDTree.UnknownFormatError: unknown format "'. format .'"'
        endif
    else
        let toReturn = self._str()
    endif

    if has_key(options, 'escape') && options['escape']
        let toReturn = shellescape(toReturn)
    endif

    if has_key(options, 'truncateTo')
        let limit = options['truncateTo']
        if len(toReturn) > limit
            let toReturn = "<" . strpart(toReturn, len(toReturn) - limit + 1)
        endif
    endif

    return toReturn
endfunction

"FUNCTION: Path._strForUI() {{{3
function! s:Path._strForUI()
    let toReturn = '/' . join(self.pathSegments, '/')
    if self.isDirectory && toReturn != '/'
        let toReturn  = toReturn . '/'
    endif
    return toReturn
endfunction

"FUNCTION: Path._strForCd() {{{3
"
" returns a string that can be used with :cd
function! s:Path._strForCd()
    return escape(self.str(), s:escape_chars)
endfunction
"FUNCTION: Path._strForEdit() {{{3
"
"Return: the string for this path that is suitable to be used with the :edit
"command
function! s:Path._strForEdit()
    let p = self.str({'format': 'UI'})
    let cwd = getcwd()

    if s:running_windows
        let p = tolower(self.str())
        let cwd = tolower(getcwd())
    endif

    let p = escape(p, s:escape_chars)

    let cwd = cwd . s:Path.Slash()

    "return a relative path if we can
    if stridx(p, cwd) ==# 0
        let p = strpart(p, strlen(cwd))
    endif

    if p ==# ''
        let p = '.'
    endif

    return p

endfunction
"FUNCTION: Path._strForGlob() {{{3
function! s:Path._strForGlob()
    let lead = s:Path.Slash()

    "if we are running windows then slap a drive letter on the front
    if s:running_windows
        let lead = self.drive . '\'
    endif

    let toReturn = lead . join(self.pathSegments, s:Path.Slash())

    if !s:running_windows
        let toReturn = escape(toReturn, s:escape_chars)
    endif
    return toReturn
endfunction
"FUNCTION: Path._str() {{{3
"
"Gets the string path for this path object that is appropriate for the OS.
"EG, in windows c:\foo\bar
"    in *nix  /foo/bar
function! s:Path._str()
    let lead = s:Path.Slash()

    "if we are running windows then slap a drive letter on the front
    if s:running_windows
        let lead = self.drive . '\'
    endif

    return lead . join(self.pathSegments, s:Path.Slash())
endfunction

"FUNCTION: Path.strTrunk() {{{3
"Gets the path without the last segment on the end.
function! s:Path.strTrunk()
    return self.drive . '/' . join(self.pathSegments[0:-2], '/')
endfunction

"FUNCTION: Path.WinToUnixPath(pathstr){{{3
"Takes in a windows path and returns the unix equiv
"
"A class level method
"
"Args:
"pathstr: the windows path to convert
function! s:Path.WinToUnixPath(pathstr)
    if !s:running_windows
        return a:pathstr
    endif

    let toReturn = a:pathstr

    "remove the x:\ of the front
    let toReturn = substitute(toReturn, '^.*:\(\\\|/\)\?', '/', "")

    "convert all \ chars to /
    let toReturn = substitute(toReturn, '\', '/', "g")

    return toReturn
endfunction

" SECTION: General Functions {{{1
"============================================================
"FUNCTION: s:bufInWindows(bnum){{{2
"[[STOLEN FROM VTREEEXPLORER.VIM]]
"Determine the number of windows open to this buffer number.
"Care of Yegappan Lakshman.  Thanks!
"
"Args:
"bnum: the subject buffers buffer number
function! s:bufInWindows(bnum)
    let cnt = 0
    let winnum = 1
    while 1
        let bufnum = winbufnr(winnum)
        if bufnum < 0
            break
        endif
        if bufnum ==# a:bnum
            let cnt = cnt + 1
        endif
        let winnum = winnum + 1
    endwhile

    return cnt
endfunction " >>>
"FUNCTION: s:checkForBrowse(dir) {{{2
"inits a secondary nerd tree in the current buffer if appropriate
function! s:checkForBrowse(dir)
    if a:dir != '' && isdirectory(a:dir)
        call s:initNerdTreeInPlace(a:dir)
    endif
endfunction
"FUNCTION: s:compareBookmarks(first, second) {{{2
"Compares two bookmarks
function! s:compareBookmarks(first, second)
    return a:first.compareTo(a:second)
endfunction

" FUNCTION: s:completeBookmarks(A,L,P) {{{2
" completion function for the bookmark commands
function! s:completeBookmarks(A,L,P)
    return filter(s:Bookmark.BookmarkNames(), 'v:val =~ "^' . a:A . '"')
endfunction
" FUNCTION: s:exec(cmd) {{{2
" same as :exec cmd  but eventignore=all is set for the duration
function! s:exec(cmd)
    let old_ei = &ei
    set ei=all
    exec a:cmd
    let &ei = old_ei
endfunction
" FUNCTION: s:findAndRevealPath() {{{2
function! s:findAndRevealPath()
    try
        let p = s:Path.New(expand("%"))
    catch /^NERDTree.InvalidArgumentsError/
        call s:echo("no file for the current buffer")
        return
    endtry

    if !s:treeExistsForTab()
        call s:initNerdTree(p.getParent().str())
    else
        if !p.isUnder(s:TreeFileNode.GetRootForTab().path)
            call s:initNerdTree(p.getParent().str())
        else
            if !s:isTreeOpen()
                call s:toggle("")
            endif
        endif
    endif
    call s:putCursorInTreeWin()
    call b:NERDTreeRoot.reveal(p)
endfunction
"FUNCTION: s:initNerdTree(name) {{{2
"Initialise the nerd tree for this tab. The tree will start in either the
"given directory, or the directory associated with the given bookmark
"
"Args:
"name: the name of a bookmark or a directory
function! s:initNerdTree(name)
    let path = {}
    if s:Bookmark.BookmarkExistsFor(a:name)
        let path = s:Bookmark.BookmarkFor(a:name).path
    else
        let dir = a:name ==# '' ? getcwd() : a:name

        "hack to get an absolute path if a relative path is given
        if dir =~ '^\.'
            let dir = getcwd() . s:Path.Slash() . dir
        endif
        let dir = resolve(dir)

        try
            let path = s:Path.New(dir)
        catch /^NERDTree.InvalidArgumentsError/
            call s:echo("No bookmark or directory found for: " . a:name)
            return
        endtry
    endif
    if !path.isDirectory
        let path = path.getParent()
    endif

    "if instructed to, then change the vim CWD to the dir the NERDTree is
    "inited in
    if g:NERDTreeChDirMode != 0
        call path.changeToDir()
    endif

    if s:treeExistsForTab()
        if s:isTreeOpen()
            call s:closeTree()
        endif
        unlet t:NERDTreeBufName
    endif

    let newRoot = s:TreeDirNode.New(path)
    call newRoot.open()

    call s:createTreeWin()
    let b:treeShowHelp = 0
    let b:NERDTreeIgnoreEnabled = 1
    let b:NERDTreeShowFiles = g:NERDTreeShowFiles
    let b:NERDTreeShowHidden = g:NERDTreeShowHidden
    let b:NERDTreeShowBookmarks = g:NERDTreeShowBookmarks
    let b:NERDTreeRoot = newRoot

    let b:NERDTreeType = "primary"

    call s:renderView()
    call b:NERDTreeRoot.putCursorHere(0, 0)
endfunction

"FUNCTION: s:initNerdTreeInPlace(dir) {{{2
function! s:initNerdTreeInPlace(dir)
    try
        let path = s:Path.New(a:dir)
    catch /^NERDTree.InvalidArgumentsError/
        call s:echo("Invalid directory name:" . a:name)
        return
    endtry

    "we want the directory buffer to disappear when we do the :edit below
    setlocal bufhidden=wipe

    let previousBuf = expand("#")

    "we need a unique name for each secondary tree buffer to ensure they are
    "all independent
    exec "silent edit " . s:nextBufferName()

    let b:NERDTreePreviousBuf = bufnr(previousBuf)

    let b:NERDTreeRoot = s:TreeDirNode.New(path)
    call b:NERDTreeRoot.open()

    "throwaway buffer options
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal nowrap
    setlocal foldcolumn=0
    setlocal nobuflisted
    setlocal nospell
    if g:NERDTreeShowLineNumbers
        setlocal nu
    else
        setlocal nonu
    endif

    iabc <buffer>

    if g:NERDTreeHighlightCursorline
        setlocal cursorline
    endif

    call s:setupStatusline()

    let b:treeShowHelp = 0
    let b:NERDTreeIgnoreEnabled = 1
    let b:NERDTreeShowFiles = g:NERDTreeShowFiles
    let b:NERDTreeShowHidden = g:NERDTreeShowHidden
    let b:NERDTreeShowBookmarks = g:NERDTreeShowBookmarks

    let b:NERDTreeType = "secondary"

    call s:bindMappings()
    setfiletype nerdtree
    " syntax highlighting
    if has("syntax") && exists("g:syntax_on")
        call s:setupSyntaxHighlighting()
    endif

    call s:renderView()
endfunction
" FUNCTION: s:initNerdTreeMirror() {{{2
function! s:initNerdTreeMirror()

    "get the names off all the nerd tree buffers
    let treeBufNames = []
    for i in range(1, tabpagenr("$"))
        let nextName = s:tabpagevar(i, 'NERDTreeBufName')
        if nextName != -1 && (!exists("t:NERDTreeBufName") || nextName != t:NERDTreeBufName)
            call add(treeBufNames, nextName)
        endif
    endfor
    let treeBufNames = s:unique(treeBufNames)

    "map the option names (that the user will be prompted with) to the nerd
    "tree buffer names
    let options = {}
    let i = 0
    while i < len(treeBufNames)
        let bufName = treeBufNames[i]
        let treeRoot = getbufvar(bufName, "NERDTreeRoot")
        let options[i+1 . '. ' . treeRoot.path.str() . '  (buf name: ' . bufName . ')'] = bufName
        let i = i + 1
    endwhile

    "work out which tree to mirror, if there is more than 1 then ask the user
    let bufferName = ''
    if len(keys(options)) > 1
        let choices = ["Choose a tree to mirror"]
        let choices = extend(choices, sort(keys(options)))
        let choice = inputlist(choices)
        if choice < 1 || choice > len(options) || choice ==# ''
            return
        endif

        let bufferName = options[sort(keys(options))[choice-1]]
    elseif len(keys(options)) ==# 1
        let bufferName = values(options)[0]
    else
        call s:echo("No trees to mirror")
        return
    endif

    if s:treeExistsForTab() && s:isTreeOpen()
        call s:closeTree()
    endif

    let t:NERDTreeBufName = bufferName
    call s:createTreeWin()
    exec 'buffer ' .  bufferName
    if !&hidden
        call s:renderView()
    endif
endfunction
" FUNCTION: s:nextBufferName() {{{2
" returns the buffer name for the next nerd tree
function! s:nextBufferName()
    let name = s:NERDTreeBufName . s:next_buffer_number
    let s:next_buffer_number += 1
    return name
endfunction
" FUNCTION: s:tabpagevar(tabnr, var) {{{2
function! s:tabpagevar(tabnr, var)
    let currentTab = tabpagenr()
    let old_ei = &ei
    set ei=all

    exec "tabnext " . a:tabnr
    let v = -1
    if exists('t:' . a:var)
        exec 'let v = t:' . a:var
    endif
    exec "tabnext " . currentTab

    let &ei = old_ei

    return v
endfunction
" Function: s:treeExistsForBuffer()   {{{2
" Returns 1 if a nerd tree root exists in the current buffer
function! s:treeExistsForBuf()
    return exists("b:NERDTreeRoot")
endfunction
" Function: s:treeExistsForTab()   {{{2
" Returns 1 if a nerd tree root exists in the current tab
function! s:treeExistsForTab()
    return exists("t:NERDTreeBufName")
endfunction
" Function: s:unique(list)   {{{2
" returns a:list without duplicates
function! s:unique(list)
  let uniqlist = []
  for elem in a:list
    if index(uniqlist, elem) ==# -1
      let uniqlist += [elem]
    endif
  endfor
  return uniqlist
endfunction
" SECTION: Public API {{{1
"============================================================
let g:NERDTreePath = s:Path
let g:NERDTreeDirNode = s:TreeDirNode
let g:NERDTreeFileNode = s:TreeFileNode
let g:NERDTreeBookmark = s:Bookmark

function! NERDTreeAddMenuItem(options)
    call s:MenuItem.Create(a:options)
endfunction

function! NERDTreeAddMenuSeparator(...)
    let opts = a:0 ? a:1 : {}
    call s:MenuItem.CreateSeparator(opts)
endfunction

function! NERDTreeAddSubmenu(options)
    return s:MenuItem.Create(a:options)
endfunction

function! NERDTreeAddKeyMap(options)
    call s:KeyMap.Create(a:options)
endfunction

function! NERDTreeRender()
    call s:renderView()
endfunction

" SECTION: View Functions {{{1
"============================================================
"FUNCTION: s:centerView() {{{2
"centers the nerd tree window around the cursor (provided the nerd tree
"options permit)
function! s:centerView()
    if g:NERDTreeAutoCenter
        let current_line = winline()
        let lines_to_top = current_line
        let lines_to_bottom = winheight(s:getTreeWinNum()) - current_line
        if lines_to_top < g:NERDTreeAutoCenterThreshold || lines_to_bottom < g:NERDTreeAutoCenterThreshold
            normal! zz
        endif
    endif
endfunction
"FUNCTION: s:closeTree() {{{2
"Closes the primary NERD tree window for this tab
function! s:closeTree()
    if !s:isTreeOpen()
        throw "NERDTree.NoTreeFoundError: no NERDTree is open"
    endif

    if winnr("$") != 1
        call s:exec(s:getTreeWinNum() . " wincmd w")
        close
        call s:exec("wincmd p")
    else
        close
    endif
endfunction

"FUNCTION: s:closeTreeIfOpen() {{{2
"Closes the NERD tree window if it is open
function! s:closeTreeIfOpen()
   if s:isTreeOpen()
      call s:closeTree()
   endif
endfunction
"FUNCTION: s:closeTreeIfQuitOnOpen() {{{2
"Closes the NERD tree window if the close on open option is set
function! s:closeTreeIfQuitOnOpen()
    if g:NERDTreeQuitOnOpen && s:isTreeOpen()
        call s:closeTree()
    endif
endfunction
"FUNCTION: s:createTreeWin() {{{2
"Inits the NERD tree window. ie. opens it, sizes it, sets all the local
"options etc
function! s:createTreeWin()
    "create the nerd tree window
    let splitLocation = g:NERDTreeWinPos ==# "left" ? "topleft " : "botright "
    let splitSize = g:NERDTreeWinSize

    if !exists('t:NERDTreeBufName')
        let t:NERDTreeBufName = s:nextBufferName()
        silent! exec splitLocation . 'vertical ' . splitSize . ' new'
        silent! exec "edit " . t:NERDTreeBufName
    else
        silent! exec splitLocation . 'vertical ' . splitSize . ' split'
        silent! exec "buffer " . t:NERDTreeBufName
    endif

    setlocal winfixwidth

    "throwaway buffer options
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal nowrap
    setlocal foldcolumn=0
    setlocal nobuflisted
    setlocal nospell
    if g:NERDTreeShowLineNumbers
        setlocal nu
    else
        setlocal nonu
    endif

    iabc <buffer>

    if g:NERDTreeHighlightCursorline
        setlocal cursorline
    endif

    call s:setupStatusline()

    call s:bindMappings()
    setfiletype nerdtree
    " syntax highlighting
    if has("syntax") && exists("g:syntax_on")
        call s:setupSyntaxHighlighting()
    endif
endfunction

"FUNCTION: s:dumpHelp  {{{2
"prints out the quick help
function! s:dumpHelp()
    let old_h = @h
    if b:treeShowHelp ==# 1
        let @h=   "\" NERD tree (" . s:NERD_tree_version . ") quickhelp~\n"
        let @h=@h."\" ============================\n"
        let @h=@h."\" File node mappings~\n"
        let @h=@h."\" ". (g:NERDTreeMouseMode ==# 3 ? "single" : "double") ."-click,\n"
        let @h=@h."\" <CR>,\n"
        if b:NERDTreeType ==# "primary"
            let @h=@h."\" ". g:NERDTreeMapActivateNode .": open in prev window\n"
        else
            let @h=@h."\" ". g:NERDTreeMapActivateNode .": open in current window\n"
        endif
        if b:NERDTreeType ==# "primary"
            let @h=@h."\" ". g:NERDTreeMapPreview .": preview\n"
        endif
        let @h=@h."\" ". g:NERDTreeMapOpenInTab.": open in new tab\n"
        let @h=@h."\" ". g:NERDTreeMapOpenInTabSilent .": open in new tab silently\n"
        let @h=@h."\" middle-click,\n"
        let @h=@h."\" ". g:NERDTreeMapOpenSplit .": open split\n"
        let @h=@h."\" ". g:NERDTreeMapPreviewSplit .": preview split\n"
        let @h=@h."\" ". g:NERDTreeMapOpenVSplit .": open vsplit\n"
        let @h=@h."\" ". g:NERDTreeMapPreviewVSplit .": preview vsplit\n"

        let @h=@h."\"\n\" ----------------------------\n"
        let @h=@h."\" Directory node mappings~\n"
        let @h=@h."\" ". (g:NERDTreeMouseMode ==# 1 ? "double" : "single") ."-click,\n"
        let @h=@h."\" ". g:NERDTreeMapActivateNode .": open & close node\n"
        let @h=@h."\" ". g:NERDTreeMapOpenRecursively .": recursively open node\n"
        let @h=@h."\" ". g:NERDTreeMapCloseDir .": close parent of node\n"
        let @h=@h."\" ". g:NERDTreeMapCloseChildren .": close all child nodes of\n"
        let @h=@h."\"    current node recursively\n"
        let @h=@h."\" middle-click,\n"
        let @h=@h."\" ". g:NERDTreeMapOpenExpl.": explore selected dir\n"

        let @h=@h."\"\n\" ----------------------------\n"
        let @h=@h."\" Bookmark table mappings~\n"
        let @h=@h."\" double-click,\n"
        let @h=@h."\" ". g:NERDTreeMapActivateNode .": open bookmark\n"
        let @h=@h."\" ". g:NERDTreeMapOpenInTab.": open in new tab\n"
        let @h=@h."\" ". g:NERDTreeMapOpenInTabSilent .": open in new tab silently\n"
        let @h=@h."\" ". g:NERDTreeMapDeleteBookmark .": delete bookmark\n"

        let @h=@h."\"\n\" ----------------------------\n"
        let @h=@h."\" Tree navigation mappings~\n"
        let @h=@h."\" ". g:NERDTreeMapJumpRoot .": go to root\n"
        let @h=@h."\" ". g:NERDTreeMapJumpParent .": go to parent\n"
        let @h=@h."\" ". g:NERDTreeMapJumpFirstChild  .": go to first child\n"
        let @h=@h."\" ". g:NERDTreeMapJumpLastChild   .": go to last child\n"
        let @h=@h."\" ". g:NERDTreeMapJumpNextSibling .": go to next sibling\n"
        let @h=@h."\" ". g:NERDTreeMapJumpPrevSibling .": go to prev sibling\n"

        let @h=@h."\"\n\" ----------------------------\n"
        let @h=@h."\" Filesystem mappings~\n"
        let @h=@h."\" ". g:NERDTreeMapChangeRoot .": change tree root to the\n"
        let @h=@h."\"    selected dir\n"
        let @h=@h."\" ". g:NERDTreeMapUpdir .": move tree root up a dir\n"
        let @h=@h."\" ". g:NERDTreeMapUpdirKeepOpen .": move tree root up a dir\n"
        let @h=@h."\"    but leave old root open\n"
        let @h=@h."\" ". g:NERDTreeMapRefresh .": refresh cursor dir\n"
        let @h=@h."\" ". g:NERDTreeMapRefreshRoot .": refresh current root\n"
        let @h=@h."\" ". g:NERDTreeMapMenu .": Show menu\n"
        let @h=@h."\" ". g:NERDTreeMapChdir .":change the CWD to the\n"
        let @h=@h."\"    selected dir\n"

        let @h=@h."\"\n\" ----------------------------\n"
        let @h=@h."\" Tree filtering mappings~\n"
        let @h=@h."\" ". g:NERDTreeMapToggleHidden .": hidden files (" . (b:NERDTreeShowHidden ? "on" : "off") . ")\n"
        let @h=@h."\" ". g:NERDTreeMapToggleFilters .": file filters (" . (b:NERDTreeIgnoreEnabled ? "on" : "off") . ")\n"
        let @h=@h."\" ". g:NERDTreeMapToggleFiles .": files (" . (b:NERDTreeShowFiles ? "on" : "off") . ")\n"
        let @h=@h."\" ". g:NERDTreeMapToggleBookmarks .": bookmarks (" . (b:NERDTreeShowBookmarks ? "on" : "off") . ")\n"

        "add quickhelp entries for each custom key map
        if len(s:KeyMap.All())
            let @h=@h."\"\n\" ----------------------------\n"
            let @h=@h."\" Custom mappings~\n"
            for i in s:KeyMap.All()
                let @h=@h."\" ". i.key .": ". i.quickhelpText ."\n"
            endfor
        endif

        let @h=@h."\"\n\" ----------------------------\n"
        let @h=@h."\" Other mappings~\n"
        let @h=@h."\" ". g:NERDTreeMapQuit .": Close the NERDTree window\n"
        let @h=@h."\" ". g:NERDTreeMapToggleZoom .": Zoom (maximize-minimize)\n"
        let @h=@h."\"    the NERDTree window\n"
        let @h=@h."\" ". g:NERDTreeMapHelp .": toggle help\n"
        let @h=@h."\"\n\" ----------------------------\n"
        let @h=@h."\" Bookmark commands~\n"
        let @h=@h."\" :Bookmark <name>\n"
        let @h=@h."\" :BookmarkToRoot <name>\n"
        let @h=@h."\" :RevealBookmark <name>\n"
        let @h=@h."\" :OpenBookmark <name>\n"
        let @h=@h."\" :ClearBookmarks [<names>]\n"
        let @h=@h."\" :ClearAllBookmarks\n"
    else
        let @h="\" Press ". g:NERDTreeMapHelp ." for help\n"
    endif

    silent! put h

    let @h = old_h
endfunction
"FUNCTION: s:echo  {{{2
"A wrapper for :echo. Appends 'NERDTree:' on the front of all messages
"
"Args:
"msg: the message to echo
function! s:echo(msg)
    redraw
    echomsg "NERDTree: " . a:msg
endfunction
"FUNCTION: s:echoWarning {{{2
"Wrapper for s:echo, sets the message type to warningmsg for this message
"Args:
"msg: the message to echo
function! s:echoWarning(msg)
    echohl warningmsg
    call s:echo(a:msg)
    echohl normal
endfunction
"FUNCTION: s:echoError {{{2
"Wrapper for s:echo, sets the message type to errormsg for this message
"Args:
"msg: the message to echo
function! s:echoError(msg)
    echohl errormsg
    call s:echo(a:msg)
    echohl normal
endfunction
"FUNCTION: s:firstUsableWindow(){{{2
"find the window number of the first normal window
function! s:firstUsableWindow()
    let i = 1
    while i <= winnr("$")
        let bnum = winbufnr(i)
        if bnum != -1 && getbufvar(bnum, '&buftype') ==# ''
                    \ && !getwinvar(i, '&previewwindow')
                    \ && (!getbufvar(bnum, '&modified') || &hidden)
            return i
        endif

        let i += 1
    endwhile
    return -1
endfunction
"FUNCTION: s:getPath(ln) {{{2
"Gets the full path to the node that is rendered on the given line number
"
"Args:
"ln: the line number to get the path for
"
"Return:
"A path if a node was selected, {} if nothing is selected.
"If the 'up a dir' line was selected then the path to the parent of the
"current root is returned
function! s:getPath(ln)
    let line = getline(a:ln)

    let rootLine = s:TreeFileNode.GetRootLineNum()

    "check to see if we have the root node
    if a:ln == rootLine
        return b:NERDTreeRoot.path
    endif

    " in case called from outside the tree
    if line !~ '^ *[|`]' || line =~ '^$'
        return {}
    endif

    if line ==# s:tree_up_dir_line
        return b:NERDTreeRoot.path.getParent()
    endif

    let indent = s:indentLevelFor(line)

    "remove the tree parts and the leading space
    let curFile = s:stripMarkupFromLine(line, 0)

    let wasdir = 0
    if curFile =~ '/$'
        let wasdir = 1
        let curFile = substitute(curFile, '/\?$', '/', "")
    endif

    let dir = ""
    let lnum = a:ln
    while lnum > 0
        let lnum = lnum - 1
        let curLine = getline(lnum)
        let curLineStripped = s:stripMarkupFromLine(curLine, 1)

        "have we reached the top of the tree?
        if lnum == rootLine
            let dir = b:NERDTreeRoot.path.str({'format': 'UI'}) . dir
            break
        endif
        if curLineStripped =~ '/$'
            let lpindent = s:indentLevelFor(curLine)
            if lpindent < indent
                let indent = indent - 1

                let dir = substitute (curLineStripped,'^\\', "", "") . dir
                continue
            endif
        endif
    endwhile
    let curFile = b:NERDTreeRoot.path.drive . dir . curFile
    let toReturn = s:Path.New(curFile)
    return toReturn
endfunction

"FUNCTION: s:getTreeWinNum() {{{2
"gets the nerd tree window number for this tab
function! s:getTreeWinNum()
    if exists("t:NERDTreeBufName")
        return bufwinnr(t:NERDTreeBufName)
    else
        return -1
    endif
endfunction
"FUNCTION: s:indentLevelFor(line) {{{2
function! s:indentLevelFor(line)
    return match(a:line, '[^ \-+~`|]') / s:tree_wid
endfunction
"FUNCTION: s:isTreeOpen() {{{2
function! s:isTreeOpen()
    return s:getTreeWinNum() != -1
endfunction
"FUNCTION: s:isWindowUsable(winnumber) {{{2
"Returns 0 if opening a file from the tree in the given window requires it to
"be split, 1 otherwise
"
"Args:
"winnumber: the number of the window in question
function! s:isWindowUsable(winnumber)
    "gotta split if theres only one window (i.e. the NERD tree)
    if winnr("$") ==# 1
        return 0
    endif

    let oldwinnr = winnr()
    call s:exec(a:winnumber . "wincmd p")
    let specialWindow = getbufvar("%", '&buftype') != '' || getwinvar('%', '&previewwindow')
    let modified = &modified
    call s:exec(oldwinnr . "wincmd p")

    "if its a special window e.g. quickfix or another explorer plugin then we
    "have to split
    if specialWindow
        return 0
    endif

    if &hidden
        return 1
    endif

    return !modified || s:bufInWindows(winbufnr(a:winnumber)) >= 2
endfunction

" FUNCTION: s:jumpToChild(direction) {{{2
" Args:
" direction: 0 if going to first child, 1 if going to last
function! s:jumpToChild(direction)
    let currentNode = s:TreeFileNode.GetSelected()
    if currentNode ==# {} || currentNode.isRoot()
        call s:echo("cannot jump to " . (a:direction ? "last" : "first") .  " child")
        return
    end
    let dirNode = currentNode.parent
    let childNodes = dirNode.getVisibleChildren()

    let targetNode = childNodes[0]
    if a:direction
        let targetNode = childNodes[len(childNodes) - 1]
    endif

    if targetNode.equals(currentNode)
        let siblingDir = currentNode.parent.findOpenDirSiblingWithVisibleChildren(a:direction)
        if siblingDir != {}
            let indx = a:direction ? siblingDir.getVisibleChildCount()-1 : 0
            let targetNode = siblingDir.getChildByIndex(indx, 1)
        endif
    endif

    call targetNode.putCursorHere(1, 0)

    call s:centerView()
endfunction


"FUNCTION: s:promptToDelBuffer(bufnum, msg){{{2
"prints out the given msg and, if the user responds by pushing 'y' then the
"buffer with the given bufnum is deleted
"
"Args:
"bufnum: the buffer that may be deleted
"msg: a message that will be echoed to the user asking them if they wish to
"     del the buffer
function! s:promptToDelBuffer(bufnum, msg)
    echo a:msg
    if nr2char(getchar()) ==# 'y'
        exec "silent bdelete! " . a:bufnum
    endif
endfunction

"FUNCTION: s:putCursorOnBookmarkTable(){{{2
"Places the cursor at the top of the bookmarks table
function! s:putCursorOnBookmarkTable()
    if !b:NERDTreeShowBookmarks
        throw "NERDTree.IllegalOperationError: cant find bookmark table, bookmarks arent active"
    endif

    let rootNodeLine = s:TreeFileNode.GetRootLineNum()

    let line = 1
    while getline(line) !~ '^>-\+Bookmarks-\+$'
        let line = line + 1
        if line >= rootNodeLine
            throw "NERDTree.BookmarkTableNotFoundError: didnt find the bookmarks table"
        endif
    endwhile
    call cursor(line, 0)
endfunction

"FUNCTION: s:putCursorInTreeWin(){{{2
"Places the cursor in the nerd tree window
function! s:putCursorInTreeWin()
    if !s:isTreeOpen()
        throw "NERDTree.InvalidOperationError: cant put cursor in NERD tree window, no window exists"
    endif

    call s:exec(s:getTreeWinNum() . "wincmd w")
endfunction

"FUNCTION: s:renderBookmarks {{{2
function! s:renderBookmarks()

    call setline(line(".")+1, ">----------Bookmarks----------")
    call cursor(line(".")+1, col("."))

    for i in s:Bookmark.Bookmarks()
        call setline(line(".")+1, i.str())
        call cursor(line(".")+1, col("."))
    endfor

    call setline(line(".")+1, '')
    call cursor(line(".")+1, col("."))
endfunction
"FUNCTION: s:renderView {{{2
"The entry function for rendering the tree
function! s:renderView()
    setlocal modifiable

    "remember the top line of the buffer and the current line so we can
    "restore the view exactly how it was
    let curLine = line(".")
    let curCol = col(".")
    let topLine = line("w0")

    "delete all lines in the buffer (being careful not to clobber a register)
    silent 1,$delete _

    call s:dumpHelp()

    "delete the blank line before the help and add one after it
    call setline(line(".")+1, "")
    call cursor(line(".")+1, col("."))

    if b:NERDTreeShowBookmarks
        call s:renderBookmarks()
    endif

    "add the 'up a dir' line
    call setline(line(".")+1, s:tree_up_dir_line)
    call cursor(line(".")+1, col("."))

    "draw the header line
    let header = b:NERDTreeRoot.path.str({'format': 'UI', 'truncateTo': winwidth(0)})
    call setline(line(".")+1, header)
    call cursor(line(".")+1, col("."))

    "draw the tree
    let old_o = @o
    let @o = b:NERDTreeRoot.renderToString()
    silent put o
    let @o = old_o

    "delete the blank line at the top of the buffer
    silent 1,1delete _

    "restore the view
    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(topLine, 1)
    normal! zt
    call cursor(curLine, curCol)
    let &scrolloff = old_scrolloff

    setlocal nomodifiable
endfunction

"FUNCTION: s:renderViewSavingPosition {{{2
"Renders the tree and ensures the cursor stays on the current node or the
"current nodes parent if it is no longer available upon re-rendering
function! s:renderViewSavingPosition()
    let currentNode = s:TreeFileNode.GetSelected()

    "go up the tree till we find a node that will be visible or till we run
    "out of nodes
    while currentNode != {} && !currentNode.isVisible() && !currentNode.isRoot()
        let currentNode = currentNode.parent
    endwhile

    call s:renderView()

    if currentNode != {}
        call currentNode.putCursorHere(0, 0)
    endif
endfunction
"FUNCTION: s:restoreScreenState() {{{2
"
"Sets the screen state back to what it was when s:saveScreenState was last
"called.
"
"Assumes the cursor is in the NERDTree window
function! s:restoreScreenState()
    if !exists("b:NERDTreeOldTopLine") || !exists("b:NERDTreeOldPos") || !exists("b:NERDTreeOldWindowSize")
        return
    endif
    exec("silent vertical resize ".b:NERDTreeOldWindowSize)

    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(b:NERDTreeOldTopLine, 0)
    normal! zt
    call setpos(".", b:NERDTreeOldPos)
    let &scrolloff=old_scrolloff
endfunction

"FUNCTION: s:saveScreenState() {{{2
"Saves the current cursor position in the current buffer and the window
"scroll position
function! s:saveScreenState()
    let win = winnr()
    try
        call s:putCursorInTreeWin()
        let b:NERDTreeOldPos = getpos(".")
        let b:NERDTreeOldTopLine = line("w0")
        let b:NERDTreeOldWindowSize = winwidth("")
        call s:exec(win . "wincmd w")
    catch /^NERDTree.InvalidOperationError/
    endtry
endfunction

"FUNCTION: s:setupStatusline() {{{2
function! s:setupStatusline()
    if g:NERDTreeStatusline != -1
        let &l:statusline = g:NERDTreeStatusline
    endif
endfunction
"FUNCTION: s:setupSyntaxHighlighting() {{{2
function! s:setupSyntaxHighlighting()
    "treeFlags are syntax items that should be invisible, but give clues as to
    "how things should be highlighted
    syn match treeFlag #\~#
    syn match treeFlag #\[RO\]#

    "highlighting for the .. (up dir) line at the top of the tree
    execute "syn match treeUp #". s:tree_up_dir_line ."#"

    "highlighting for the ~/+ symbols for the directory nodes
    syn match treeClosable #\~\<#
    syn match treeClosable #\~\.#
    syn match treeOpenable #+\<#
    syn match treeOpenable #+\.#he=e-1

    "highlighting for the tree structural parts
    syn match treePart #|#
    syn match treePart #`#
    syn match treePartFile #[|`]-#hs=s+1 contains=treePart

    "quickhelp syntax elements
    syn match treeHelpKey #" \{1,2\}[^ ]*:#hs=s+2,he=e-1
    syn match treeHelpKey #" \{1,2\}[^ ]*,#hs=s+2,he=e-1
    syn match treeHelpTitle #" .*\~#hs=s+2,he=e-1 contains=treeFlag
    syn match treeToggleOn #".*(on)#hs=e-2,he=e-1 contains=treeHelpKey
    syn match treeToggleOff #".*(off)#hs=e-3,he=e-1 contains=treeHelpKey
    syn match treeHelpCommand #" :.\{-}\>#hs=s+3
    syn match treeHelp  #^".*# contains=treeHelpKey,treeHelpTitle,treeFlag,treeToggleOff,treeToggleOn,treeHelpCommand

    "highlighting for readonly files
    syn match treeRO #.*\[RO\]#hs=s+2 contains=treeFlag,treeBookmark,treePart,treePartFile

    "highlighting for sym links
    syn match treeLink #[^-| `].* -> # contains=treeBookmark,treeOpenable,treeClosable,treeDirSlash

    "highlighing for directory nodes and file nodes
    syn match treeDirSlash #/#
    syn match treeDir #[^-| `].*/# contains=treeLink,treeDirSlash,treeOpenable,treeClosable
    syn match treeExecFile  #[|`]-.*\*\($\| \)# contains=treeLink,treePart,treeRO,treePartFile,treeBookmark
    syn match treeFile  #|-.*# contains=treeLink,treePart,treeRO,treePartFile,treeBookmark,treeExecFile
    syn match treeFile  #`-.*# contains=treeLink,treePart,treeRO,treePartFile,treeBookmark,treeExecFile
    syn match treeCWD #^/.*$#

    "highlighting for bookmarks
    syn match treeBookmark # {.*}#hs=s+1

    "highlighting for the bookmarks table
    syn match treeBookmarksLeader #^>#
    syn match treeBookmarksHeader #^>-\+Bookmarks-\+$# contains=treeBookmarksLeader
    syn match treeBookmarkName #^>.\{-} #he=e-1 contains=treeBookmarksLeader
    syn match treeBookmark #^>.*$# contains=treeBookmarksLeader,treeBookmarkName,treeBookmarksHeader

    if g:NERDChristmasTree
        hi def link treePart Special
        hi def link treePartFile Type
        hi def link treeFile Normal
        hi def link treeExecFile Title
        hi def link treeDirSlash Identifier
        hi def link treeClosable Type
    else
        hi def link treePart Normal
        hi def link treePartFile Normal
        hi def link treeFile Normal
        hi def link treeClosable Title
    endif

    hi def link treeBookmarksHeader statement
    hi def link treeBookmarksLeader ignore
    hi def link treeBookmarkName Identifier
    hi def link treeBookmark normal

    hi def link treeHelp String
    hi def link treeHelpKey Identifier
    hi def link treeHelpCommand Identifier
    hi def link treeHelpTitle Macro
    hi def link treeToggleOn Question
    hi def link treeToggleOff WarningMsg

    hi def link treeDir Directory
    hi def link treeUp Directory
    hi def link treeCWD Statement
    hi def link treeLink Macro
    hi def link treeOpenable Title
    hi def link treeFlag ignore
    hi def link treeRO WarningMsg
    hi def link treeBookmark Statement

    hi def link NERDTreeCurrentNode Search
endfunction

"FUNCTION: s:stripMarkupFromLine(line, removeLeadingSpaces){{{2
"returns the given line with all the tree parts stripped off
"
"Args:
"line: the subject line
"removeLeadingSpaces: 1 if leading spaces are to be removed (leading spaces =
"any spaces before the actual text of the node)
function! s:stripMarkupFromLine(line, removeLeadingSpaces)
    let line = a:line
    "remove the tree parts and the leading space
    let line = substitute (line, s:tree_markup_reg,"","")

    "strip off any read only flag
    let line = substitute (line, ' \[RO\]', "","")

    "strip off any bookmark flags
    let line = substitute (line, ' {[^}]*}', "","")

    "strip off any executable flags
    let line = substitute (line, '*\ze\($\| \)', "","")

    let wasdir = 0
    if line =~ '/$'
        let wasdir = 1
    endif
    let line = substitute (line,' -> .*',"","") " remove link to
    if wasdir ==# 1
        let line = substitute (line, '/\?$', '/', "")
    endif

    if a:removeLeadingSpaces
        let line = substitute (line, '^ *', '', '')
    endif

    return line
endfunction

"FUNCTION: s:toggle(dir) {{{2
"Toggles the NERD tree. I.e the NERD tree is open, it is closed, if it is
"closed it is restored or initialized (if it doesnt exist)
"
"Args:
"dir: the full path for the root node (is only used if the NERD tree is being
"initialized.
function! s:toggle(dir)
    if s:treeExistsForTab()
        if !s:isTreeOpen()
            call s:createTreeWin()
            if !&hidden
                call s:renderView()
            endif
            call s:restoreScreenState()
        else
            call s:closeTree()
        endif
    else
        call s:initNerdTree(a:dir)
    endif
endfunction
"SECTION: Interface bindings {{{1
"============================================================
"FUNCTION: s:activateNode(forceKeepWindowOpen) {{{2
"If the current node is a file, open it in the previous window (or a new one
"if the previous is modified). If it is a directory then it is opened.
"
"args:
"forceKeepWindowOpen - dont close the window even if NERDTreeQuitOnOpen is set
function! s:activateNode(forceKeepWindowOpen)
    if getline(".") ==# s:tree_up_dir_line
        return s:upDir(0)
    endif

    let treenode = s:TreeFileNode.GetSelected()
    if treenode != {}
        call treenode.activate(a:forceKeepWindowOpen)
    else
        let bookmark = s:Bookmark.GetSelected()
        if !empty(bookmark)
            call bookmark.activate()
        endif
    endif
endfunction

"FUNCTION: s:bindMappings() {{{2
function! s:bindMappings()
    " set up mappings and commands for this buffer
    nnoremap <silent> <buffer> <middlerelease> :call <SID>handleMiddleMouse()<cr>
    nnoremap <silent> <buffer> <leftrelease> <leftrelease>:call <SID>checkForActivate()<cr>
    nnoremap <silent> <buffer> <2-leftmouse> :call <SID>activateNode(0)<cr>

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapActivateNode . " :call <SID>activateNode(0)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapOpenSplit ." :call <SID>openEntrySplit(0,0)<cr>"
    exec "nnoremap <silent> <buffer> <cr> :call <SID>activateNode(0)<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapPreview ." :call <SID>previewNode(0)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapPreviewSplit ." :call <SID>previewNode(1)<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapOpenVSplit ." :call <SID>openEntrySplit(1,0)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapPreviewVSplit ." :call <SID>previewNode(2)<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapOpenRecursively ." :call <SID>openNodeRecursively()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapUpdirKeepOpen ." :call <SID>upDir(1)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapUpdir ." :call <SID>upDir(0)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapChangeRoot ." :call <SID>chRoot()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapChdir ." :call <SID>chCwd()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapQuit ." :call <SID>closeTreeWindow()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapRefreshRoot ." :call <SID>refreshRoot()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapRefresh ." :call <SID>refreshCurrent()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapHelp ." :call <SID>displayHelp()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapToggleZoom ." :call <SID>toggleZoom()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapToggleHidden ." :call <SID>toggleShowHidden()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapToggleFilters ." :call <SID>toggleIgnoreFilter()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapToggleFiles ." :call <SID>toggleShowFiles()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapToggleBookmarks ." :call <SID>toggleShowBookmarks()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapCloseDir ." :call <SID>closeCurrentDir()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapCloseChildren ." :call <SID>closeChildren()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapMenu ." :call <SID>showMenu()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapJumpParent ." :call <SID>jumpToParent()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapJumpNextSibling ." :call <SID>jumpToSibling(1)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapJumpPrevSibling ." :call <SID>jumpToSibling(0)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapJumpFirstChild ." :call <SID>jumpToFirstChild()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapJumpLastChild ." :call <SID>jumpToLastChild()<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapJumpRoot ." :call <SID>jumpToRoot()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapOpenInTab ." :call <SID>openInNewTab(0)<cr>"
    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapOpenInTabSilent ." :call <SID>openInNewTab(1)<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapOpenExpl ." :call <SID>openExplorer()<cr>"

    exec "nnoremap <silent> <buffer> ". g:NERDTreeMapDeleteBookmark ." :call <SID>deleteBookmark()<cr>"

    "bind all the user custom maps
    call s:KeyMap.BindAll()

    command! -buffer -nargs=1 Bookmark :call <SID>bookmarkNode('<args>')
    command! -buffer -complete=customlist,s:completeBookmarks -nargs=1 RevealBookmark :call <SID>revealBookmark('<args>')
    command! -buffer -complete=customlist,s:completeBookmarks -nargs=1 OpenBookmark :call <SID>openBookmark('<args>')
    command! -buffer -complete=customlist,s:completeBookmarks -nargs=* ClearBookmarks call <SID>clearBookmarks('<args>')
    command! -buffer -complete=customlist,s:completeBookmarks -nargs=+ BookmarkToRoot call s:Bookmark.ToRoot('<args>')
    command! -buffer -nargs=0 ClearAllBookmarks call s:Bookmark.ClearAll() <bar> call <SID>renderView()
    command! -buffer -nargs=0 ReadBookmarks call s:Bookmark.CacheBookmarks(0) <bar> call <SID>renderView()
    command! -buffer -nargs=0 WriteBookmarks call s:Bookmark.Write()
endfunction

" FUNCTION: s:bookmarkNode(name) {{{2
" Associate the current node with the given name
function! s:bookmarkNode(name)
    let currentNode = s:TreeFileNode.GetSelected()
    if currentNode != {}
        try
            call currentNode.bookmark(a:name)
            call s:renderView()
        catch /^NERDTree.IllegalBookmarkNameError/
            call s:echo("bookmark names must not contain spaces")
        endtry
    else
        call s:echo("select a node first")
    endif
endfunction
"FUNCTION: s:checkForActivate() {{{2
"Checks if the click should open the current node, if so then activate() is
"called (directories are automatically opened if the symbol beside them is
"clicked)
function! s:checkForActivate()
    let currentNode = s:TreeFileNode.GetSelected()
    if currentNode != {}
        let startToCur = strpart(getline(line(".")), 0, col("."))
        let char = strpart(startToCur, strlen(startToCur)-1, 1)

        "if they clicked a dir, check if they clicked on the + or ~ sign
        "beside it
        if currentNode.path.isDirectory
            if startToCur =~ s:tree_markup_reg . '$' && char =~ '[+~]'
                call s:activateNode(0)
                return
            endif
        endif

        if (g:NERDTreeMouseMode ==# 2 && currentNode.path.isDirectory) || g:NERDTreeMouseMode ==# 3
            if char !~ s:tree_markup_reg && startToCur !~ '\/$'
                call s:activateNode(0)
                return
            endif
        endif
    endif
endfunction

" FUNCTION: s:chCwd() {{{2
function! s:chCwd()
    let treenode = s:TreeFileNode.GetSelected()
    if treenode ==# {}
        call s:echo("Select a node first")
        return
    endif

    try
        call treenode.path.changeToDir()
    catch /^NERDTree.PathChangeError/
        call s:echoWarning("could not change cwd")
    endtry
endfunction

" FUNCTION: s:chRoot() {{{2
" changes the current root to the selected one
function! s:chRoot()
    let treenode = s:TreeFileNode.GetSelected()
    if treenode ==# {}
        call s:echo("Select a node first")
        return
    endif

    call treenode.makeRoot()
    call s:renderView()
    call b:NERDTreeRoot.putCursorHere(0, 0)
endfunction

" FUNCTION: s:clearBookmarks(bookmarks) {{{2
function! s:clearBookmarks(bookmarks)
    if a:bookmarks ==# ''
        let currentNode = s:TreeFileNode.GetSelected()
        if currentNode != {}
            call currentNode.clearBoomarks()
        endif
    else
        for name in split(a:bookmarks, ' ')
            let bookmark = s:Bookmark.BookmarkFor(name)
            call bookmark.delete()
        endfor
    endif
    call s:renderView()
endfunction
" FUNCTION: s:closeChildren() {{{2
" closes all childnodes of the current node
function! s:closeChildren()
    let currentNode = s:TreeDirNode.GetSelected()
    if currentNode ==# {}
        call s:echo("Select a node first")
        return
    endif

    call currentNode.closeChildren()
    call s:renderView()
    call currentNode.putCursorHere(0, 0)
endfunction
" FUNCTION: s:closeCurrentDir() {{{2
" closes the parent dir of the current node
function! s:closeCurrentDir()
    let treenode = s:TreeFileNode.GetSelected()
    if treenode ==# {}
        call s:echo("Select a node first")
        return
    endif

    let parent = treenode.parent
    if parent ==# {} || parent.isRoot()
        call s:echo("cannot close tree root")
    else
        call treenode.parent.close()
        call s:renderView()
        call treenode.parent.putCursorHere(0, 0)
    endif
endfunction
" FUNCTION: s:closeTreeWindow() {{{2
" close the tree window
function! s:closeTreeWindow()
    if b:NERDTreeType ==# "secondary" && b:NERDTreePreviousBuf != -1
        exec "buffer " . b:NERDTreePreviousBuf
    else
        if winnr("$") > 1
            call s:closeTree()
        else
            call s:echo("Cannot close last window")
        endif
    endif
endfunction
" FUNCTION: s:deleteBookmark() {{{2
" if the cursor is on a bookmark, prompt to delete
function! s:deleteBookmark()
    let bookmark = s:Bookmark.GetSelected()
    if bookmark ==# {}
        call s:echo("Put the cursor on a bookmark")
        return
    endif

    echo  "Are you sure you wish to delete the bookmark:\n\"" . bookmark.name . "\" (yN):"

    if  nr2char(getchar()) ==# 'y'
        try
            call bookmark.delete()
            call s:renderView()
            redraw
        catch /^NERDTree/
            call s:echoWarning("Could not remove bookmark")
        endtry
    else
        call s:echo("delete aborted" )
    endif

endfunction

" FUNCTION: s:displayHelp() {{{2
" toggles the help display
function! s:displayHelp()
    let b:treeShowHelp = b:treeShowHelp ? 0 : 1
    call s:renderView()
    call s:centerView()
endfunction

" FUNCTION: s:handleMiddleMouse() {{{2
function! s:handleMiddleMouse()
    let curNode = s:TreeFileNode.GetSelected()
    if curNode ==# {}
        call s:echo("Put the cursor on a node first" )
        return
    endif

    if curNode.path.isDirectory
        call s:openExplorer()
    else
        call s:openEntrySplit(0,0)
    endif
endfunction


" FUNCTION: s:jumpToFirstChild() {{{2
" wrapper for the jump to child method
function! s:jumpToFirstChild()
    call s:jumpToChild(0)
endfunction

" FUNCTION: s:jumpToLastChild() {{{2
" wrapper for the jump to child method
function! s:jumpToLastChild()
    call s:jumpToChild(1)
endfunction

" FUNCTION: s:jumpToParent() {{{2
" moves the cursor to the parent of the current node
function! s:jumpToParent()
    let currentNode = s:TreeFileNode.GetSelected()
    if !empty(currentNode)
        if !empty(currentNode.parent)
            call currentNode.parent.putCursorHere(1, 0)
            call s:centerView()
        else
            call s:echo("cannot jump to parent")
        endif
    else
        call s:echo("put the cursor on a node first")
    endif
endfunction

" FUNCTION: s:jumpToRoot() {{{2
" moves the cursor to the root node
function! s:jumpToRoot()
    call b:NERDTreeRoot.putCursorHere(1, 0)
    call s:centerView()
endfunction

" FUNCTION: s:jumpToSibling() {{{2
" moves the cursor to the sibling of the current node in the given direction
"
" Args:
" forward: 1 if the cursor should move to the next sibling, 0 if it should
" move back to the previous sibling
function! s:jumpToSibling(forward)
    let currentNode = s:TreeFileNode.GetSelected()
    if !empty(currentNode)
        let sibling = currentNode.findSibling(a:forward)

        if !empty(sibling)
            call sibling.putCursorHere(1, 0)
            call s:centerView()
        endif
    else
        call s:echo("put the cursor on a node first")
    endif
endfunction

" FUNCTION: s:openBookmark(name) {{{2
" put the cursor on the given bookmark and, if its a file, open it
function! s:openBookmark(name)
    try
        let targetNode = s:Bookmark.GetNodeForName(a:name, 0)
        call targetNode.putCursorHere(0, 1)
        redraw!
    catch /^NERDTree.BookmarkedNodeNotFoundError/
        call s:echo("note - target node is not cached")
        let bookmark = s:Bookmark.BookmarkFor(a:name)
        let targetNode = s:TreeFileNode.New(bookmark.path)
    endtry
    if targetNode.path.isDirectory
        call targetNode.openExplorer()
    else
        call targetNode.open()
    endif
endfunction
" FUNCTION: s:openEntrySplit(vertical, forceKeepWindowOpen) {{{2
"Opens the currently selected file from the explorer in a
"new window
"
"args:
"forceKeepWindowOpen - dont close the window even if NERDTreeQuitOnOpen is set
function! s:openEntrySplit(vertical, forceKeepWindowOpen)
    let treenode = s:TreeFileNode.GetSelected()
    if treenode != {}
        if a:vertical
            call treenode.openVSplit()
        else
            call treenode.openSplit()
        endif
        if !a:forceKeepWindowOpen
            call s:closeTreeIfQuitOnOpen()
        endif
    else
        call s:echo("select a node first")
    endif
endfunction

" FUNCTION: s:openExplorer() {{{2
function! s:openExplorer()
    let treenode = s:TreeDirNode.GetSelected()
    if treenode != {}
        call treenode.openExplorer()
    else
        call s:echo("select a node first")
    endif
endfunction

" FUNCTION: s:openInNewTab(stayCurrentTab) {{{2
" Opens the selected node or bookmark in a new tab
" Args:
" stayCurrentTab: if 1 then vim will stay in the current tab, if 0 then vim
" will go to the tab where the new file is opened
function! s:openInNewTab(stayCurrentTab)
    let target = s:TreeFileNode.GetSelected()
    if target == {}
        let target = s:Bookmark.GetSelected()
    endif

    if target != {}
        call target.openInNewTab({'stayInCurrentTab': a:stayCurrentTab})
    endif
endfunction

" FUNCTION: s:openNodeRecursively() {{{2
function! s:openNodeRecursively()
    let treenode = s:TreeFileNode.GetSelected()
    if treenode ==# {} || treenode.path.isDirectory ==# 0
        call s:echo("Select a directory node first" )
    else
        call s:echo("Recursively opening node. Please wait...")
        call treenode.openRecursively()
        call s:renderView()
        redraw
        call s:echo("Recursively opening node. Please wait... DONE")
    endif

endfunction

"FUNCTION: s:previewNode() {{{2
"Args:
"   openNewWin: if 0, use the previous window, if 1 open in new split, if 2
"               open in a vsplit
function! s:previewNode(openNewWin)
    let currentBuf = bufnr("")
    if a:openNewWin > 0
        call s:openEntrySplit(a:openNewWin ==# 2,1)
    else
        call s:activateNode(1)
    end
    call s:exec(bufwinnr(currentBuf) . "wincmd w")
endfunction

" FUNCTION: s:revealBookmark(name) {{{2
" put the cursor on the node associate with the given name
function! s:revealBookmark(name)
    try
        let targetNode = s:Bookmark.GetNodeForName(a:name, 0)
        call targetNode.putCursorHere(0, 1)
    catch /^NERDTree.BookmarkNotFoundError/
        call s:echo("Bookmark isnt cached under the current root")
    endtry
endfunction
" FUNCTION: s:refreshRoot() {{{2
" Reloads the current root. All nodes below this will be lost and the root dir
" will be reloaded.
function! s:refreshRoot()
    call s:echo("Refreshing the root node. This could take a while...")
    call b:NERDTreeRoot.refresh()
    call s:renderView()
    redraw
    call s:echo("Refreshing the root node. This could take a while... DONE")
endfunction

" FUNCTION: s:refreshCurrent() {{{2
" refreshes the root for the current node
function! s:refreshCurrent()
    let treenode = s:TreeDirNode.GetSelected()
    if treenode ==# {}
        call s:echo("Refresh failed. Select a node first")
        return
    endif

    call s:echo("Refreshing node. This could take a while...")
    call treenode.refresh()
    call s:renderView()
    redraw
    call s:echo("Refreshing node. This could take a while... DONE")
endfunction
" FUNCTION: s:showMenu() {{{2
function! s:showMenu()
    let curNode = s:TreeFileNode.GetSelected()
    if curNode ==# {}
        call s:echo("Put the cursor on a node first" )
        return
    endif

    let mc = s:MenuController.New(s:MenuItem.AllEnabled())
    call mc.showMenu()
endfunction

" FUNCTION: s:toggleIgnoreFilter() {{{2
" toggles the use of the NERDTreeIgnore option
function! s:toggleIgnoreFilter()
    let b:NERDTreeIgnoreEnabled = !b:NERDTreeIgnoreEnabled
    call s:renderViewSavingPosition()
    call s:centerView()
endfunction

" FUNCTION: s:toggleShowBookmarks() {{{2
" toggles the display of bookmarks
function! s:toggleShowBookmarks()
    let b:NERDTreeShowBookmarks = !b:NERDTreeShowBookmarks
    if b:NERDTreeShowBookmarks
        call s:renderView()
        call s:putCursorOnBookmarkTable()
    else
        call s:renderViewSavingPosition()
    endif
    call s:centerView()
endfunction
" FUNCTION: s:toggleShowFiles() {{{2
" toggles the display of hidden files
function! s:toggleShowFiles()
    let b:NERDTreeShowFiles = !b:NERDTreeShowFiles
    call s:renderViewSavingPosition()
    call s:centerView()
endfunction

" FUNCTION: s:toggleShowHidden() {{{2
" toggles the display of hidden files
function! s:toggleShowHidden()
    let b:NERDTreeShowHidden = !b:NERDTreeShowHidden
    call s:renderViewSavingPosition()
    call s:centerView()
endfunction

" FUNCTION: s:toggleZoom() {{2
" zoom (maximize/minimize) the NERDTree window
function! s:toggleZoom()
    if exists("b:NERDTreeZoomed") && b:NERDTreeZoomed
        let size = exists("b:NERDTreeOldWindowSize") ? b:NERDTreeOldWindowSize : g:NERDTreeWinSize
        exec "silent vertical resize ". size
        let b:NERDTreeZoomed = 0
    else
        exec "vertical resize"
        let b:NERDTreeZoomed = 1
    endif
endfunction

"FUNCTION: s:upDir(keepState) {{{2
"moves the tree up a level
"
"Args:
"keepState: 1 if the current root should be left open when the tree is
"re-rendered
function! s:upDir(keepState)
    let cwd = b:NERDTreeRoot.path.str({'format': 'UI'})
    if cwd ==# "/" || cwd =~ '^[^/]..$'
        call s:echo("already at top dir")
    else
        if !a:keepState
            call b:NERDTreeRoot.close()
        endif

        let oldRoot = b:NERDTreeRoot

        if empty(b:NERDTreeRoot.parent)
            let path = b:NERDTreeRoot.path.getParent()
            let newRoot = s:TreeDirNode.New(path)
            call newRoot.open()
            call newRoot.transplantChild(b:NERDTreeRoot)
            let b:NERDTreeRoot = newRoot
        else
            let b:NERDTreeRoot = b:NERDTreeRoot.parent
        endif

        if g:NERDTreeChDirMode ==# 2
            call b:NERDTreeRoot.path.changeToDir()
        endif

        call s:renderView()
        call oldRoot.putCursorHere(0, 0)
    endif
endfunction


"reset &cpo back to users setting
let &cpo = s:old_cpo

" vim: set sw=4 sts=4 et fdm=marker:
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  .vim/plugin/taglist.vim                                                                             0000644 0001751 0001751 00000440732 12126773534 014301  0                                                                                                    ustar   x0199365                        x0199365                                                                                                                                                                                                               " File: taglist.vim
" Author: Yegappan Lakshmanan (yegappan AT yahoo DOT com)
" Version: 4.5
" Last Modified: September 21, 2007
" Copyright: Copyright (C) 2002-2007 Yegappan Lakshmanan
"            Permission is hereby granted to use and distribute this code,
"            with or without modifications, provided that this copyright
"            notice is copied with it. Like anything else that's free,
"            taglist.vim is provided *as is* and comes with no warranty of any
"            kind, either expressed or implied. In no event will the copyright
"            holder be liable for any damamges resulting from the use of this
"            software.
"
" The "Tag List" plugin is a source code browser plugin for Vim and provides
" an overview of the structure of the programming language files and allows
" you to efficiently browse through source code files for different
" programming languages.  You can visit the taglist plugin home page for more
" information:
"
"       http://vim-taglist.sourceforge.net
"
" You can subscribe to the taglist mailing list to post your questions
" or suggestions for improvement or to report bugs. Visit the following
" page for subscribing to the mailing list:
"
"       http://groups.yahoo.com/group/taglist/
"
" For more information about using this plugin, after installing the
" taglist plugin, use the ":help taglist" command.
"
" Installation
" ------------
" 1. Download the taglist.zip file and unzip the files to the $HOME/.vim
"    or the $HOME/vimfiles or the $VIM/vimfiles directory. This should
"    unzip the following two files (the directory structure should be
"    preserved):
"
"       plugin/taglist.vim - main taglist plugin file
"       doc/taglist.txt    - documentation (help) file
"
"    Refer to the 'add-plugin', 'add-global-plugin' and 'runtimepath'
"    Vim help pages for more details about installing Vim plugins.
" 2. Change to the $HOME/.vim/doc or $HOME/vimfiles/doc or
"    $VIM/vimfiles/doc directory, start Vim and run the ":helptags ."
"    command to process the taglist help file.
" 3. If the exuberant ctags utility is not present in your PATH, then set the
"    Tlist_Ctags_Cmd variable to point to the location of the exuberant ctags
"    utility (not to the directory) in the .vimrc file.
" 4. If you are running a terminal/console version of Vim and the
"    terminal doesn't support changing the window width then set the
"    'Tlist_Inc_Winwidth' variable to 0 in the .vimrc file.
" 5. Restart Vim.
" 6. You can now use the ":TlistToggle" command to open/close the taglist
"    window. You can use the ":help taglist" command to get more
"    information about using the taglist plugin.
"
" ****************** Do not modify after this line ************************

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

if !exists('loaded_taglist')
    " First time loading the taglist plugin
    "
    " To speed up the loading of Vim, the taglist plugin uses autoload
    " mechanism to load the taglist functions.
    " Only define the configuration variables, user commands and some
    " auto-commands and finish sourcing the file

    " The taglist plugin requires the built-in Vim system() function. If this
    " function is not available, then don't load the plugin.
    if !exists('*system')
        echomsg 'Taglist: Vim system() built-in function is not available. ' .
                    \ 'Plugin is not loaded.'
        let loaded_taglist = 'no'
        let &cpo = s:cpo_save
        finish
    endif

    " Location of the exuberant ctags tool
    if !exists('Tlist_Ctags_Cmd')
        if executable('exuberant-ctags')
            " On Debian Linux, exuberant ctags is installed
            " as exuberant-ctags
            let Tlist_Ctags_Cmd = 'exuberant-ctags'
        elseif executable('exctags')
            " On Free-BSD, exuberant ctags is installed as exctags
            let Tlist_Ctags_Cmd = 'exctags'
        elseif executable('ctags')
            let Tlist_Ctags_Cmd = 'ctags'
        elseif executable('ctags.exe')
            let Tlist_Ctags_Cmd = 'ctags.exe'
        elseif executable('tags')
            let Tlist_Ctags_Cmd = 'tags'
        else
            echomsg 'Taglist: Exuberant ctags (http://ctags.sf.net) ' .
                        \ 'not found in PATH. Plugin is not loaded.'
            " Skip loading the plugin
            let loaded_taglist = 'no'
            let &cpo = s:cpo_save
            finish
        endif
    endif


    " Automatically open the taglist window on Vim startup
    if !exists('Tlist_Auto_Open')
        let Tlist_Auto_Open = 0
    endif

    " When the taglist window is toggle opened, move the cursor to the
    " taglist window
    if !exists('Tlist_GainFocus_On_ToggleOpen')
        let Tlist_GainFocus_On_ToggleOpen = 0
    endif

    " Process files even when the taglist window is not open
    if !exists('Tlist_Process_File_Always')
        let Tlist_Process_File_Always = 0
    endif

    if !exists('Tlist_Show_Menu')
        let Tlist_Show_Menu = 0
    endif

    " Tag listing sort type - 'name' or 'order'
    if !exists('Tlist_Sort_Type')
        let Tlist_Sort_Type = 'order'
    endif

    " Tag listing window split (horizontal/vertical) control
    if !exists('Tlist_Use_Horiz_Window')
        let Tlist_Use_Horiz_Window = 0
    endif

    " Open the vertically split taglist window on the left or on the right
    " side.  This setting is relevant only if Tlist_Use_Horiz_Window is set to
    " zero (i.e.  only for vertically split windows)
    if !exists('Tlist_Use_Right_Window')
        let Tlist_Use_Right_Window = 0
    endif

    " Increase Vim window width to display vertically split taglist window.
    " For MS-Windows version of Vim running in a MS-DOS window, this must be
    " set to 0 otherwise the system may hang due to a Vim limitation.
    if !exists('Tlist_Inc_Winwidth')
        if (has('win16') || has('win95')) && !has('gui_running')
            let Tlist_Inc_Winwidth = 0
        else
            let Tlist_Inc_Winwidth = 1
        endif
    endif

    " Vertically split taglist window width setting
    if !exists('Tlist_WinWidth')
        let Tlist_WinWidth = 30
    endif

    " Horizontally split taglist window height setting
    if !exists('Tlist_WinHeight')
        let Tlist_WinHeight = 10
    endif

    " Display tag prototypes or tag names in the taglist window
    if !exists('Tlist_Display_Prototype')
        let Tlist_Display_Prototype = 0
    endif

    " Display tag scopes in the taglist window
    if !exists('Tlist_Display_Tag_Scope')
        let Tlist_Display_Tag_Scope = 1
    endif

    " Use single left mouse click to jump to a tag. By default this is disabled.
    " Only double click using the mouse will be processed.
    if !exists('Tlist_Use_SingleClick')
        let Tlist_Use_SingleClick = 0
    endif

    " Control whether additional help is displayed as part of the taglist or
    " not.  Also, controls whether empty lines are used to separate the tag
    " tree.
    if !exists('Tlist_Compact_Format')
        let Tlist_Compact_Format = 0
    endif

    " Exit Vim if only the taglist window is currently open. By default, this is
    " set to zero.
    if !exists('Tlist_Exit_OnlyWindow')
        let Tlist_Exit_OnlyWindow = 0
    endif

    " Automatically close the folds for the non-active files in the taglist
    " window
    if !exists('Tlist_File_Fold_Auto_Close')
        let Tlist_File_Fold_Auto_Close = 0
    endif

    " Close the taglist window when a tag is selected
    if !exists('Tlist_Close_On_Select')
        let Tlist_Close_On_Select = 0
    endif

    " Automatically update the taglist window to display tags for newly
    " edited files
    if !exists('Tlist_Auto_Update')
        let Tlist_Auto_Update = 1
    endif

    " Automatically highlight the current tag
    if !exists('Tlist_Auto_Highlight_Tag')
        let Tlist_Auto_Highlight_Tag = 1
    endif
    
    " Automatically highlight the current tag on entering a buffer
    if !exists('Tlist_Highlight_Tag_On_BufEnter')
        let Tlist_Highlight_Tag_On_BufEnter = 1
    endif

    " Enable fold column to display the folding for the tag tree
    if !exists('Tlist_Enable_Fold_Column')
        let Tlist_Enable_Fold_Column = 1
    endif

    " Display the tags for only one file in the taglist window
    if !exists('Tlist_Show_One_File')
        let Tlist_Show_One_File = 0
    endif

    if !exists('Tlist_Max_Submenu_Items')
        let Tlist_Max_Submenu_Items = 20
    endif

    if !exists('Tlist_Max_Tag_Length')
        let Tlist_Max_Tag_Length = 10
    endif

    " Do not change the name of the taglist title variable. The winmanager
    " plugin relies on this name to determine the title for the taglist
    " plugin.
    let TagList_title = "__Tag_List__"

    " Taglist debug messages
    let s:tlist_msg = ''

    " Define the taglist autocommand to automatically open the taglist window
    " on Vim startup
    if g:Tlist_Auto_Open
        autocmd VimEnter * nested call s:Tlist_Window_Check_Auto_Open()
    endif

    " Refresh the taglist
    if g:Tlist_Process_File_Always
        autocmd BufEnter * call s:Tlist_Refresh()
    endif

    if g:Tlist_Show_Menu
        autocmd GUIEnter * call s:Tlist_Menu_Init()
    endif

    " When the taglist buffer is created when loading a Vim session file,
    " the taglist buffer needs to be initialized. The BufFilePost event
    " is used to handle this case.
    autocmd BufFilePost __Tag_List__ call s:Tlist_Vim_Session_Load()

    " Define the user commands to manage the taglist window
    command! -nargs=0 -bar TlistToggle call s:Tlist_Window_Toggle()
    command! -nargs=0 -bar TlistOpen call s:Tlist_Window_Open()
    " For backwards compatiblity define the Tlist command
    command! -nargs=0 -bar Tlist TlistToggle
    command! -nargs=+ -complete=file TlistAddFiles
                \  call s:Tlist_Add_Files(<f-args>)
    command! -nargs=+ -complete=dir TlistAddFilesRecursive
                \ call s:Tlist_Add_Files_Recursive(<f-args>)
    command! -nargs=0 -bar TlistClose call s:Tlist_Window_Close()
    command! -nargs=0 -bar TlistUpdate call s:Tlist_Update_Current_File()
    command! -nargs=0 -bar TlistHighlightTag call s:Tlist_Window_Highlight_Tag(
                        \ fnamemodify(bufname('%'), ':p'), line('.'), 2, 1)
    " For backwards compatiblity define the TlistSync command
    command! -nargs=0 -bar TlistSync TlistHighlightTag
    command! -nargs=* -complete=buffer TlistShowPrototype
                \ echo Tlist_Get_Tag_Prototype_By_Line(<f-args>)
    command! -nargs=* -complete=buffer TlistShowTag
                \ echo Tlist_Get_Tagname_By_Line(<f-args>)
    command! -nargs=* -complete=file TlistSessionLoad
                \ call s:Tlist_Session_Load(<q-args>)
    command! -nargs=* -complete=file TlistSessionSave
                \ call s:Tlist_Session_Save(<q-args>)
    command! -bar TlistLock let Tlist_Auto_Update=0
    command! -bar TlistUnlock let Tlist_Auto_Update=1

    " Commands for enabling/disabling debug and to display debug messages
    command! -nargs=? -complete=file -bar TlistDebug
                \ call s:Tlist_Debug_Enable(<q-args>)
    command! -nargs=0 -bar TlistUndebug  call s:Tlist_Debug_Disable()
    command! -nargs=0 -bar TlistMessages call s:Tlist_Debug_Show()

    " Define autocommands to autoload the taglist plugin when needed.

    " Trick to get the current script ID
    map <SID>xx <SID>xx
    let s:tlist_sid = substitute(maparg('<SID>xx'), '<SNR>\(\d\+_\)xx$',
                                \ '\1', '')
    unmap <SID>xx

    exe 'autocmd FuncUndefined *' . s:tlist_sid . 'Tlist_* source ' .
                \ escape(expand('<sfile>'), ' ')
    exe 'autocmd FuncUndefined *' . s:tlist_sid . 'Tlist_Window_* source ' .
                \ escape(expand('<sfile>'), ' ')
    exe 'autocmd FuncUndefined *' . s:tlist_sid . 'Tlist_Menu_* source ' .
                \ escape(expand('<sfile>'), ' ')
    exe 'autocmd FuncUndefined Tlist_* source ' .
                \ escape(expand('<sfile>'), ' ')
    exe 'autocmd FuncUndefined TagList_* source ' .
                \ escape(expand('<sfile>'), ' ')

    let loaded_taglist = 'fast_load_done'

    if g:Tlist_Show_Menu && has('gui_running')
        call s:Tlist_Menu_Init()
    endif

    " restore 'cpo'
    let &cpo = s:cpo_save
    finish
endif

if !exists('s:tlist_sid')
    " Two or more versions of taglist plugin are installed. Don't
    " load this version of the plugin.
    finish
endif

unlet! s:tlist_sid

if loaded_taglist != 'fast_load_done'
    " restore 'cpo'
    let &cpo = s:cpo_save
    finish
endif

" Taglist plugin functionality is available
let loaded_taglist = 'available'

"------------------- end of user configurable options --------------------

" Default language specific settings for supported file types and tag types
"
" Variable name format:
"
"       s:tlist_def_{vim_ftype}_settings
" 
" vim_ftype - Filetype detected by Vim
"
" Value format:
"
"       <ctags_ftype>;<flag>:<name>;<flag>:<name>;...
"
" ctags_ftype - File type supported by exuberant ctags
" flag        - Flag supported by exuberant ctags to generate a tag type
" name        - Name of the tag type used in the taglist window to display the
"               tags of this type
"

" assembly language
let s:tlist_def_asm_settings = 'asm;d:define;l:label;m:macro;t:type'

" aspperl language
let s:tlist_def_aspperl_settings = 'asp;f:function;s:sub;v:variable'

" aspvbs language
let s:tlist_def_aspvbs_settings = 'asp;f:function;s:sub;v:variable'

" awk language
let s:tlist_def_awk_settings = 'awk;f:function'

" beta language
let s:tlist_def_beta_settings = 'beta;f:fragment;s:slot;v:pattern'

" c language
let s:tlist_def_c_settings = 'c;d:macro;g:enum;s:struct;u:union;t:typedef;' .
                           \ 'v:variable;f:function'

" c++ language
let s:tlist_def_cpp_settings = 'c++;n:namespace;v:variable;d:macro;t:typedef;' .
                             \ 'c:class;g:enum;s:struct;u:union;f:function'

" c# language
let s:tlist_def_cs_settings = 'c#;d:macro;t:typedef;n:namespace;c:class;' .
                             \ 'E:event;g:enum;s:struct;i:interface;' .
                             \ 'p:properties;m:method'

" cobol language
let s:tlist_def_cobol_settings = 'cobol;d:data;f:file;g:group;p:paragraph;' .
                               \ 'P:program;s:section'

" eiffel language
let s:tlist_def_eiffel_settings = 'eiffel;c:class;f:feature'

" erlang language
let s:tlist_def_erlang_settings = 'erlang;d:macro;r:record;m:module;f:function'

" expect (same as tcl) language
let s:tlist_def_expect_settings = 'tcl;c:class;f:method;p:procedure'

" fortran language
let s:tlist_def_fortran_settings = 'fortran;p:program;b:block data;' .
                    \ 'c:common;e:entry;i:interface;k:type;l:label;m:module;' .
                    \ 'n:namelist;t:derived;v:variable;f:function;s:subroutine'

" HTML language
let s:tlist_def_html_settings = 'html;a:anchor;f:javascript function'

" java language
let s:tlist_def_java_settings = 'java;p:package;c:class;i:interface;' .
                              \ 'f:field;m:method'

" javascript language
let s:tlist_def_javascript_settings = 'javascript;f:function'

" lisp language
let s:tlist_def_lisp_settings = 'lisp;f:function'

" lua language
let s:tlist_def_lua_settings = 'lua;f:function'

" makefiles
let s:tlist_def_make_settings = 'make;m:macro'

" pascal language
let s:tlist_def_pascal_settings = 'pascal;f:function;p:procedure'

" perl language
let s:tlist_def_perl_settings = 'perl;c:constant;l:label;p:package;s:subroutine'

" php language
let s:tlist_def_php_settings = 'php;c:class;d:constant;v:variable;f:function'

" python language
let s:tlist_def_python_settings = 'python;c:class;m:member;f:function'

" rexx language
let s:tlist_def_rexx_settings = 'rexx;s:subroutine'

" ruby language
let s:tlist_def_ruby_settings = 'ruby;c:class;f:method;F:function;' .
                              \ 'm:singleton method'

" scheme language
let s:tlist_def_scheme_settings = 'scheme;s:set;f:function'

" shell language
let s:tlist_def_sh_settings = 'sh;f:function'

" C shell language
let s:tlist_def_csh_settings = 'sh;f:function'

" Z shell language
let s:tlist_def_zsh_settings = 'sh;f:function'

" slang language
let s:tlist_def_slang_settings = 'slang;n:namespace;f:function'

" sml language
let s:tlist_def_sml_settings = 'sml;e:exception;c:functor;s:signature;' .
                             \ 'r:structure;t:type;v:value;f:function'

" sql language
let s:tlist_def_sql_settings = 'sql;c:cursor;F:field;P:package;r:record;' .
            \ 's:subtype;t:table;T:trigger;v:variable;f:function;p:procedure'

" tcl language
let s:tlist_def_tcl_settings = 'tcl;c:class;f:method;m:method;p:procedure'

" vera language
let s:tlist_def_vera_settings = 'vera;c:class;d:macro;e:enumerator;' .
                                \ 'f:function;g:enum;m:member;p:program;' .
                                \ 'P:prototype;t:task;T:typedef;v:variable;' .
                                \ 'x:externvar'

"verilog language
let s:tlist_def_verilog_settings = 'verilog;m:module;c:constant;P:parameter;' .
            \ 'e:event;r:register;t:task;w:write;p:port;v:variable;f:function'

" vim language
let s:tlist_def_vim_settings = 'vim;a:autocmds;v:variable;f:function'

" yacc language
let s:tlist_def_yacc_settings = 'yacc;l:label'

"------------------- end of language specific options --------------------

" Vim window size is changed by the taglist plugin or not
let s:tlist_winsize_chgd = -1
" Taglist window is maximized or not
let s:tlist_win_maximized = 0
" Name of files in the taglist
let s:tlist_file_names=''
" Number of files in the taglist
let s:tlist_file_count = 0
" Number of filetypes supported by taglist
let s:tlist_ftype_count = 0
" Is taglist part of other plugins like winmanager or cream?
let s:tlist_app_name = "none"
" Are we displaying brief help text
let s:tlist_brief_help = 1
" List of files removed on user request
let s:tlist_removed_flist = ""
" Index of current file displayed in the taglist window
let s:tlist_cur_file_idx = -1
" Taglist menu is empty or not
let s:tlist_menu_empty = 1

" An autocommand is used to refresh the taglist window when entering any
" buffer. We don't want to refresh the taglist window if we are entering the
" file window from one of the taglist functions. The 'Tlist_Skip_Refresh'
" variable is used to skip the refresh of the taglist window and is set
" and cleared appropriately.
let s:Tlist_Skip_Refresh = 0

" Tlist_Window_Display_Help()
function! s:Tlist_Window_Display_Help()
    if s:tlist_app_name == "winmanager"
        " To handle a bug in the winmanager plugin, add a space at the
        " last line
        call setline('$', ' ')
    endif

    if s:tlist_brief_help
        " Add the brief help
        call append(0, '" Press <F1> to display help text')
    else
        " Add the extensive help
        call append(0, '" <enter> : Jump to tag definition')
        call append(1, '" o : Jump to tag definition in new window')
        call append(2, '" p : Preview the tag definition')
        call append(3, '" <space> : Display tag prototype')
        call append(4, '" u : Update tag list')
        call append(5, '" s : Select sort field')
        call append(6, '" d : Remove file from taglist')
        call append(7, '" x : Zoom-out/Zoom-in taglist window')
        call append(8, '" + : Open a fold')
        call append(9, '" - : Close a fold')
        call append(10, '" * : Open all folds')
        call append(11, '" = : Close all folds')
        call append(12, '" [[ : Move to the start of previous file')
        call append(13, '" ]] : Move to the start of next file')
        call append(14, '" q : Close the taglist window')
        call append(15, '" <F1> : Remove help text')
    endif
endfunction

" Tlist_Window_Toggle_Help_Text()
" Toggle taglist plugin help text between the full version and the brief
" version
function! s:Tlist_Window_Toggle_Help_Text()
    if g:Tlist_Compact_Format
        " In compact display mode, do not display help
        return
    endif

    " Include the empty line displayed after the help text
    let brief_help_size = 1
    let full_help_size = 16

    setlocal modifiable

    " Set report option to a huge value to prevent informational messages
    " while deleting the lines
    let old_report = &report
    set report=99999

    " Remove the currently highlighted tag. Otherwise, the help text
    " might be highlighted by mistake
    match none

    " Toggle between brief and full help text
    if s:tlist_brief_help
        let s:tlist_brief_help = 0

        " Remove the previous help
        exe '1,' . brief_help_size . ' delete _'

        " Adjust the start/end line numbers for the files
        call s:Tlist_Window_Update_Line_Offsets(0, 1, full_help_size - brief_help_size)
    else
        let s:tlist_brief_help = 1

        " Remove the previous help
        exe '1,' . full_help_size . ' delete _'

        " Adjust the start/end line numbers for the files
        call s:Tlist_Window_Update_Line_Offsets(0, 0, full_help_size - brief_help_size)
    endif

    call s:Tlist_Window_Display_Help()

    " Restore the report option
    let &report = old_report

    setlocal nomodifiable
endfunction

" Taglist debug support
let s:tlist_debug = 0

" File for storing the debug messages
let s:tlist_debug_file = ''

" Tlist_Debug_Enable
" Enable logging of taglist debug messages.
function! s:Tlist_Debug_Enable(...)
    let s:tlist_debug = 1

    " Check whether a valid file name is supplied.
    if a:1 != ''
        let s:tlist_debug_file = fnamemodify(a:1, ':p')

        " Empty the log file
        exe 'redir! > ' . s:tlist_debug_file
        redir END

        " Check whether the log file is present/created
        if !filewritable(s:tlist_debug_file)
            call s:Tlist_Warning_Msg('Taglist: Unable to create log file '
                        \ . s:tlist_debug_file)
            let s:tlist_debug_file = ''
        endif
    endif
endfunction

" Tlist_Debug_Disable
" Disable logging of taglist debug messages.
function! s:Tlist_Debug_Disable(...)
    let s:tlist_debug = 0
    let s:tlist_debug_file = ''
endfunction

" Tlist_Debug_Show
" Display the taglist debug messages in a new window
function! s:Tlist_Debug_Show()
    if s:tlist_msg == ''
        call s:Tlist_Warning_Msg('Taglist: No debug messages')
        return
    endif

    " Open a new window to display the taglist debug messages
    new taglist_debug.txt
    " Delete all the lines (if the buffer already exists)
    silent! %delete _
    " Add the messages
    silent! put =s:tlist_msg
    " Move the cursor to the first line
    normal! gg
endfunction

" Tlist_Log_Msg
" Log the supplied debug message along with the time
function! s:Tlist_Log_Msg(msg)
    if s:tlist_debug
        if s:tlist_debug_file != ''
            exe 'redir >> ' . s:tlist_debug_file
            silent echon strftime('%H:%M:%S') . ': ' . a:msg . "\n"
            redir END
        else
            " Log the message into a variable
            " Retain only the last 3000 characters
            let len = strlen(s:tlist_msg)
            if len > 3000
                let s:tlist_msg = strpart(s:tlist_msg, len - 3000)
            endif
            let s:tlist_msg = s:tlist_msg . strftime('%H:%M:%S') . ': ' . 
                        \ a:msg . "\n"
        endif
    endif
endfunction

" Tlist_Warning_Msg()
" Display a message using WarningMsg highlight group
function! s:Tlist_Warning_Msg(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

" Last returned file index for file name lookup.
" Used to speed up file lookup
let s:tlist_file_name_idx_cache = -1

" Tlist_Get_File_Index()
" Return the index of the specified filename
function! s:Tlist_Get_File_Index(fname)
    if s:tlist_file_count == 0 || a:fname == ''
        return -1
    endif

    " If the new filename is same as the last accessed filename, then
    " return that index
    if s:tlist_file_name_idx_cache != -1 &&
                \ s:tlist_file_name_idx_cache < s:tlist_file_count
        if s:tlist_{s:tlist_file_name_idx_cache}_filename == a:fname
            " Same as the last accessed file
            return s:tlist_file_name_idx_cache
        endif
    endif

    " First, check whether the filename is present
    let s_fname = a:fname . "\n"
    let i = stridx(s:tlist_file_names, s_fname)
    if i == -1
        let s:tlist_file_name_idx_cache = -1
        return -1
    endif

    " Second, compute the file name index
    let nl_txt = substitute(strpart(s:tlist_file_names, 0, i), "[^\n]", '', 'g')
    let s:tlist_file_name_idx_cache = strlen(nl_txt)
    return s:tlist_file_name_idx_cache
endfunction

" Last returned file index for line number lookup.
" Used to speed up file lookup
let s:tlist_file_lnum_idx_cache = -1

" Tlist_Window_Get_File_Index_By_Linenum()
" Return the index of the filename present in the specified line number
" Line number refers to the line number in the taglist window
function! s:Tlist_Window_Get_File_Index_By_Linenum(lnum)
    call s:Tlist_Log_Msg('Tlist_Window_Get_File_Index_By_Linenum (' . a:lnum . ')')

    " First try to see whether the new line number is within the range
    " of the last returned file
    if s:tlist_file_lnum_idx_cache != -1 &&
                \ s:tlist_file_lnum_idx_cache < s:tlist_file_count
        if a:lnum >= s:tlist_{s:tlist_file_lnum_idx_cache}_start &&
                    \ a:lnum <= s:tlist_{s:tlist_file_lnum_idx_cache}_end
            return s:tlist_file_lnum_idx_cache
        endif
    endif

    let fidx = -1

    if g:Tlist_Show_One_File
        " Displaying only one file in the taglist window. Check whether
        " the line is within the tags displayed for that file
        if s:tlist_cur_file_idx != -1
            if a:lnum >= s:tlist_{s:tlist_cur_file_idx}_start
                        \ && a:lnum <= s:tlist_{s:tlist_cur_file_idx}_end
                let fidx = s:tlist_cur_file_idx
            endif

        endif
    else
        " Do a binary search in the taglist
        let left = 0
        let right = s:tlist_file_count - 1

        while left < right
            let mid = (left + right) / 2

            if a:lnum >= s:tlist_{mid}_start && a:lnum <= s:tlist_{mid}_end
                let s:tlist_file_lnum_idx_cache = mid
                return mid
            endif

            if a:lnum < s:tlist_{mid}_start
                let right = mid - 1
            else
                let left = mid + 1
            endif
        endwhile

        if left >= 0 && left < s:tlist_file_count
                    \ && a:lnum >= s:tlist_{left}_start
                    \ && a:lnum <= s:tlist_{left}_end
            let fidx = left
        endif
    endif

    let s:tlist_file_lnum_idx_cache = fidx

    return fidx
endfunction

" Tlist_Exe_Cmd_No_Acmds
" Execute the specified Ex command after disabling autocommands
function! s:Tlist_Exe_Cmd_No_Acmds(cmd)
    let old_eventignore = &eventignore
    set eventignore=all
    exe a:cmd
    let &eventignore = old_eventignore
endfunction

" Tlist_Skip_File()
" Check whether tag listing is supported for the specified file
function! s:Tlist_Skip_File(filename, ftype)
    " Skip buffers with no names and buffers with filetype not set
    if a:filename == '' || a:ftype == ''
        return 1
    endif

    " Skip files which are not supported by exuberant ctags
    " First check whether default settings for this filetype are available.
    " If it is not available, then check whether user specified settings are
    " available. If both are not available, then don't list the tags for this
    " filetype
    let var = 's:tlist_def_' . a:ftype . '_settings'
    if !exists(var)
        let var = 'g:tlist_' . a:ftype . '_settings'
        if !exists(var)
            return 1
        endif
    endif

    " Skip files which are not readable or files which are not yet stored
    " to the disk
    if !filereadable(a:filename)
        return 1
    endif

    return 0
endfunction

" Tlist_User_Removed_File
" Returns 1 if a file is removed by a user from the taglist
function! s:Tlist_User_Removed_File(filename)
    return stridx(s:tlist_removed_flist, a:filename . "\n") != -1
endfunction

" Tlist_Update_Remove_List
" Update the list of user removed files from the taglist
" add == 1, add the file to the removed list
" add == 0, delete the file from the removed list
function! s:Tlist_Update_Remove_List(filename, add)
    if a:add
        let s:tlist_removed_flist = s:tlist_removed_flist . a:filename . "\n"
    else
        let idx = stridx(s:tlist_removed_flist, a:filename . "\n")
        let text_before = strpart(s:tlist_removed_flist, 0, idx)
        let rem_text = strpart(s:tlist_removed_flist, idx)
        let next_idx = stridx(rem_text, "\n")
        let text_after = strpart(rem_text, next_idx + 1)

        let s:tlist_removed_flist = text_before . text_after
    endif
endfunction

" Tlist_FileType_Init
" Initialize the ctags arguments and tag variable for the specified
" file type
function! s:Tlist_FileType_Init(ftype)
    call s:Tlist_Log_Msg('Tlist_FileType_Init (' . a:ftype . ')')
    " If the user didn't specify any settings, then use the default
    " ctags args. Otherwise, use the settings specified by the user
    let var = 'g:tlist_' . a:ftype . '_settings'
    if exists(var)
        " User specified ctags arguments
        let settings = {var} . ';'
    else
        " Default ctags arguments
        let var = 's:tlist_def_' . a:ftype . '_settings'
        if !exists(var)
            " No default settings for this file type. This filetype is
            " not supported
            return 0
        endif
        let settings = s:tlist_def_{a:ftype}_settings . ';'
    endif

    let msg = 'Taglist: Invalid ctags option setting - ' . settings

    " Format of the option that specifies the filetype and ctags arugments:
    "
    "       <language_name>;flag1:name1;flag2:name2;flag3:name3
    "

    " Extract the file type to pass to ctags. This may be different from the
    " file type detected by Vim
    let pos = stridx(settings, ';')
    if pos == -1
        call s:Tlist_Warning_Msg(msg)
        return 0
    endif
    let ctags_ftype = strpart(settings, 0, pos)
    if ctags_ftype == ''
        call s:Tlist_Warning_Msg(msg)
        return 0
    endif
    " Make sure a valid filetype is supplied. If the user didn't specify a
    " valid filetype, then the ctags option settings may be treated as the
    " filetype
    if ctags_ftype =~ ':'
        call s:Tlist_Warning_Msg(msg)
        return 0
    endif

    " Remove the file type from settings
    let settings = strpart(settings, pos + 1)
    if settings == ''
        call s:Tlist_Warning_Msg(msg)
        return 0
    endif

    " Process all the specified ctags flags. The format is
    " flag1:name1;flag2:name2;flag3:name3
    let ctags_flags = ''
    let cnt = 0
    while settings != ''
        " Extract the flag
        let pos = stridx(settings, ':')
        if pos == -1
            call s:Tlist_Warning_Msg(msg)
            return 0
        endif
        let flag = strpart(settings, 0, pos)
        if flag == ''
            call s:Tlist_Warning_Msg(msg)
            return 0
        endif
        " Remove the flag from settings
        let settings = strpart(settings, pos + 1)

        " Extract the tag type name
        let pos = stridx(settings, ';')
        if pos == -1
            call s:Tlist_Warning_Msg(msg)
            return 0
        endif
        let name = strpart(settings, 0, pos)
        if name == ''
            call s:Tlist_Warning_Msg(msg)
            return 0
        endif
        let settings = strpart(settings, pos + 1)

        let cnt = cnt + 1

        let s:tlist_{a:ftype}_{cnt}_name = flag
        let s:tlist_{a:ftype}_{cnt}_fullname = name
        let ctags_flags = ctags_flags . flag
    endwhile

    let s:tlist_{a:ftype}_ctags_args = '--language-force=' . ctags_ftype .
                            \ ' --' . ctags_ftype . '-types=' . ctags_flags
    let s:tlist_{a:ftype}_count = cnt
    let s:tlist_{a:ftype}_ctags_flags = ctags_flags

    " Save the filetype name
    let s:tlist_ftype_{s:tlist_ftype_count}_name = a:ftype
    let s:tlist_ftype_count = s:tlist_ftype_count + 1

    return 1
endfunction

" Tlist_Detect_Filetype
" Determine the filetype for the specified file using the filetypedetect
" autocmd.
function! s:Tlist_Detect_Filetype(fname)
    " Ignore the filetype autocommands
    let old_eventignore = &eventignore
    set eventignore=FileType

    " Save the 'filetype', as this will be changed temporarily
    let old_filetype = &filetype

    " Run the filetypedetect group of autocommands to determine
    " the filetype
    exe 'doautocmd filetypedetect BufRead ' . a:fname

    " Save the detected filetype
    let ftype = &filetype

    " Restore the previous state
    let &filetype = old_filetype
    let &eventignore = old_eventignore

    return ftype
endfunction

" Tlist_Get_Buffer_Filetype
" Get the filetype for the specified buffer
function! s:Tlist_Get_Buffer_Filetype(bnum)
    let buf_ft = getbufvar(a:bnum, '&filetype')

    if bufloaded(a:bnum)
        " For loaded buffers, the 'filetype' is already determined
        return buf_ft
    endif

    " For unloaded buffers, if the 'filetype' option is set, return it
    if buf_ft != ''
        return buf_ft
    endif

    " Skip non-existent buffers
    if !bufexists(a:bnum)
        return ''
    endif

    " For buffers whose filetype is not yet determined, try to determine
    " the filetype
    let bname = bufname(a:bnum)

    return s:Tlist_Detect_Filetype(bname)
endfunction

" Tlist_Discard_TagInfo
" Discard the stored tag information for a file
function! s:Tlist_Discard_TagInfo(fidx)
    call s:Tlist_Log_Msg('Tlist_Discard_TagInfo (' .
                \ s:tlist_{a:fidx}_filename . ')')
    let ftype = s:tlist_{a:fidx}_filetype

    " Discard information about the tags defined in the file
    let i = 1
    while i <= s:tlist_{a:fidx}_tag_count
        let fidx_i = 's:tlist_' . a:fidx . '_' . i
        unlet! {fidx_i}_tag
        unlet! {fidx_i}_tag_name
        unlet! {fidx_i}_tag_type
        unlet! {fidx_i}_ttype_idx
        unlet! {fidx_i}_tag_proto
        unlet! {fidx_i}_tag_searchpat
        unlet! {fidx_i}_tag_linenum
        let i = i + 1
    endwhile

    let s:tlist_{a:fidx}_tag_count = 0

    " Discard information about tag type groups
    let i = 1
    while i <= s:tlist_{ftype}_count
        let ttype = s:tlist_{ftype}_{i}_name
        if s:tlist_{a:fidx}_{ttype} != ''
            let fidx_ttype = 's:tlist_' . a:fidx . '_' . ttype
            let {fidx_ttype} = ''
            let {fidx_ttype}_offset = 0
            let cnt = {fidx_ttype}_count
            let {fidx_ttype}_count = 0
            let j = 1
            while j <= cnt
                unlet! {fidx_ttype}_{j}
                let j = j + 1
            endwhile
        endif
        let i = i + 1
    endwhile

    " Discard the stored menu command also
    let s:tlist_{a:fidx}_menu_cmd = ''
endfunction

" Tlist_Window_Update_Line_Offsets
" Update the line offsets for tags for files starting from start_idx
" and displayed in the taglist window by the specified offset
function! s:Tlist_Window_Update_Line_Offsets(start_idx, increment, offset)
    let i = a:start_idx

    while i < s:tlist_file_count
        if s:tlist_{i}_visible
            " Update the start/end line number only if the file is visible
            if a:increment
                let s:tlist_{i}_start = s:tlist_{i}_start + a:offset
                let s:tlist_{i}_end = s:tlist_{i}_end + a:offset
            else
                let s:tlist_{i}_start = s:tlist_{i}_start - a:offset
                let s:tlist_{i}_end = s:tlist_{i}_end - a:offset
            endif
        endif
        let i = i + 1
    endwhile
endfunction

" Tlist_Discard_FileInfo
" Discard the stored information for a file
function! s:Tlist_Discard_FileInfo(fidx)
    call s:Tlist_Log_Msg('Tlist_Discard_FileInfo (' .
                \ s:tlist_{a:fidx}_filename . ')')
    call s:Tlist_Discard_TagInfo(a:fidx)

    let ftype = s:tlist_{a:fidx}_filetype

    let i = 1
    while i <= s:tlist_{ftype}_count
        let ttype = s:tlist_{ftype}_{i}_name
        unlet! s:tlist_{a:fidx}_{ttype}
        unlet! s:tlist_{a:fidx}_{ttype}_offset
        unlet! s:tlist_{a:fidx}_{ttype}_count
        let i = i + 1
    endwhile

    unlet! s:tlist_{a:fidx}_filename
    unlet! s:tlist_{a:fidx}_sort_type
    unlet! s:tlist_{a:fidx}_filetype
    unlet! s:tlist_{a:fidx}_mtime
    unlet! s:tlist_{a:fidx}_start
    unlet! s:tlist_{a:fidx}_end
    unlet! s:tlist_{a:fidx}_valid
    unlet! s:tlist_{a:fidx}_visible
    unlet! s:tlist_{a:fidx}_tag_count
    unlet! s:tlist_{a:fidx}_menu_cmd
endfunction

" Tlist_Window_Remove_File_From_Display
" Remove the specified file from display
function! s:Tlist_Window_Remove_File_From_Display(fidx)
    call s:Tlist_Log_Msg('Tlist_Window_Remove_File_From_Display (' .
                \ s:tlist_{a:fidx}_filename . ')')
    " If the file is not visible then no need to remove it
    if !s:tlist_{a:fidx}_visible
        return
    endif

    " Remove the tags displayed for the specified file from the window
    let start = s:tlist_{a:fidx}_start
    " Include the empty line after the last line also
    if g:Tlist_Compact_Format
        let end = s:tlist_{a:fidx}_end
    else
        let end = s:tlist_{a:fidx}_end + 1
    endif

    setlocal modifiable
    exe 'silent! ' . start . ',' . end . 'delete _'
    setlocal nomodifiable

    " Correct the start and end line offsets for all the files following
    " this file, as the tags for this file are removed
    call s:Tlist_Window_Update_Line_Offsets(a:fidx + 1, 0, end - start + 1)
endfunction

" Tlist_Remove_File
" Remove the file under the cursor or the specified file index
" user_request - User requested to remove the file from taglist
function! s:Tlist_Remove_File(file_idx, user_request)
    let fidx = a:file_idx

    if fidx == -1
        let fidx = s:Tlist_Window_Get_File_Index_By_Linenum(line('.'))
        if fidx == -1
            return
        endif
    endif
    call s:Tlist_Log_Msg('Tlist_Remove_File (' .
                \ s:tlist_{fidx}_filename . ', ' . a:user_request . ')')

    let save_winnr = winnr()
    let winnum = bufwinnr(g:TagList_title)
    if winnum != -1
        " Taglist window is open, remove the file from display

        if save_winnr != winnum
            let old_eventignore = &eventignore
            set eventignore=all
            exe winnum . 'wincmd w'
        endif

        call s:Tlist_Window_Remove_File_From_Display(fidx)

        if save_winnr != winnum
            exe save_winnr . 'wincmd w'
            let &eventignore = old_eventignore
        endif
    endif

    let fname = s:tlist_{fidx}_filename

    if a:user_request
        " As the user requested to remove the file from taglist,
        " add it to the removed list
        call s:Tlist_Update_Remove_List(fname, 1)
    endif

    " Remove the file name from the taglist list of filenames
    let idx = stridx(s:tlist_file_names, fname . "\n")
    let text_before = strpart(s:tlist_file_names, 0, idx)
    let rem_text = strpart(s:tlist_file_names, idx)
    let next_idx = stridx(rem_text, "\n")
    let text_after = strpart(rem_text, next_idx + 1)
    let s:tlist_file_names = text_before . text_after

    call s:Tlist_Discard_FileInfo(fidx)

    " Shift all the file variables by one index
    let i = fidx + 1

    while i < s:tlist_file_count
        let j = i - 1

        let s:tlist_{j}_filename = s:tlist_{i}_filename
        let s:tlist_{j}_sort_type = s:tlist_{i}_sort_type
        let s:tlist_{j}_filetype = s:tlist_{i}_filetype
        let s:tlist_{j}_mtime = s:tlist_{i}_mtime
        let s:tlist_{j}_start = s:tlist_{i}_start
        let s:tlist_{j}_end = s:tlist_{i}_end
        let s:tlist_{j}_valid = s:tlist_{i}_valid
        let s:tlist_{j}_visible = s:tlist_{i}_visible
        let s:tlist_{j}_tag_count = s:tlist_{i}_tag_count
        let s:tlist_{j}_menu_cmd = s:tlist_{i}_menu_cmd

        let k = 1
        while k <= s:tlist_{j}_tag_count
            let s:tlist_{j}_{k}_tag = s:tlist_{i}_{k}_tag
            let s:tlist_{j}_{k}_tag_name = s:tlist_{i}_{k}_tag_name
            let s:tlist_{j}_{k}_tag_type = s:Tlist_Get_Tag_Type_By_Tag(i, k)
            let s:tlist_{j}_{k}_ttype_idx = s:tlist_{i}_{k}_ttype_idx
            let s:tlist_{j}_{k}_tag_proto = s:Tlist_Get_Tag_Prototype(i, k)
            let s:tlist_{j}_{k}_tag_searchpat = s:Tlist_Get_Tag_SearchPat(i, k)
            let s:tlist_{j}_{k}_tag_linenum = s:Tlist_Get_Tag_Linenum(i, k)
            let k = k + 1
        endwhile

        let ftype = s:tlist_{i}_filetype

        let k = 1
        while k <= s:tlist_{ftype}_count
            let ttype = s:tlist_{ftype}_{k}_name
            let s:tlist_{j}_{ttype} = s:tlist_{i}_{ttype}
            let s:tlist_{j}_{ttype}_offset = s:tlist_{i}_{ttype}_offset
            let s:tlist_{j}_{ttype}_count = s:tlist_{i}_{ttype}_count
            if s:tlist_{j}_{ttype} != ''
                let l = 1
                while l <= s:tlist_{j}_{ttype}_count
                    let s:tlist_{j}_{ttype}_{l} = s:tlist_{i}_{ttype}_{l}
                    let l = l + 1
                endwhile
            endif
            let k = k + 1
        endwhile

        " As the file and tag information is copied to the new index,
        " discard the previous information
        call s:Tlist_Discard_FileInfo(i)

        let i = i + 1
    endwhile

    " Reduce the number of files displayed
    let s:tlist_file_count = s:tlist_file_count - 1

    if g:Tlist_Show_One_File
        " If the tags for only one file is displayed and if we just
        " now removed that file, then invalidate the current file idx
        if s:tlist_cur_file_idx == fidx
            let s:tlist_cur_file_idx = -1
        endif
    endif
endfunction

" Tlist_Window_Goto_Window
" Goto the taglist window
function! s:Tlist_Window_Goto_Window()
    let winnum = bufwinnr(g:TagList_title)
    if winnum != -1
        if winnr() != winnum
            call s:Tlist_Exe_Cmd_No_Acmds(winnum . 'wincmd w')
        endif
    endif
endfunction

" Tlist_Window_Create
" Create a new taglist window. If it is already open, jump to it
function! s:Tlist_Window_Create()
    call s:Tlist_Log_Msg('Tlist_Window_Create()')
    " If the window is open, jump to it
    let winnum = bufwinnr(g:TagList_title)
    if winnum != -1
        " Jump to the existing window
        if winnr() != winnum
            exe winnum . 'wincmd w'
        endif
        return
    endif

    " If used with winmanager don't open windows. Winmanager will handle
    " the window/buffer management
    if s:tlist_app_name == "winmanager"
        return
    endif

    " Create a new window. If user prefers a horizontal window, then open
    " a horizontally split window. Otherwise open a vertically split
    " window
    if g:Tlist_Use_Horiz_Window
        " Open a horizontally split window
        let win_dir = 'botright'
        " Horizontal window height
        let win_size = g:Tlist_WinHeight
    else
        if s:tlist_winsize_chgd == -1
            " Open a vertically split window. Increase the window size, if
            " needed, to accomodate the new window
            if g:Tlist_Inc_Winwidth &&
                        \ &columns < (80 + g:Tlist_WinWidth)
                " Save the original window position
                let s:tlist_pre_winx = getwinposx()
                let s:tlist_pre_winy = getwinposy()

                " one extra column is needed to include the vertical split
                let &columns= &columns + g:Tlist_WinWidth + 1

                let s:tlist_winsize_chgd = 1
            else
                let s:tlist_winsize_chgd = 0
            endif
        endif

        if g:Tlist_Use_Right_Window
            " Open the window at the rightmost place
            let win_dir = 'botright vertical'
        else
            " Open the window at the leftmost place
            let win_dir = 'topleft vertical'
        endif
        let win_size = g:Tlist_WinWidth
    endif

    " If the tag listing temporary buffer already exists, then reuse it.
    " Otherwise create a new buffer
    let bufnum = bufnr(g:TagList_title)
    if bufnum == -1
        " Create a new buffer
        let wcmd = g:TagList_title
    else
        " Edit the existing buffer
        let wcmd = '+buffer' . bufnum
    endif

    " Create the taglist window
    exe 'silent! ' . win_dir . ' ' . win_size . 'split ' . wcmd

    " Save the new window position
    let s:tlist_winx = getwinposx()
    let s:tlist_winy = getwinposy()

    " Initialize the taglist window
    call s:Tlist_Window_Init()
endfunction

" Tlist_Window_Zoom
" Zoom (maximize/minimize) the taglist window
function! s:Tlist_Window_Zoom()
    if s:tlist_win_maximized
        " Restore the window back to the previous size
        if g:Tlist_Use_Horiz_Window
            exe 'resize ' . g:Tlist_WinHeight
        else
            exe 'vert resize ' . g:Tlist_WinWidth
        endif
        let s:tlist_win_maximized = 0
    else
        " Set the window size to the maximum possible without closing other
        " windows
        if g:Tlist_Use_Horiz_Window
            resize
        else
            vert resize
        endif
        let s:tlist_win_maximized = 1
    endif
endfunction

" Tlist_Ballon_Expr
" When the mouse cursor is over a tag in the taglist window, display the
" tag prototype (balloon)
function! Tlist_Ballon_Expr()
    " Get the file index
    let fidx = s:Tlist_Window_Get_File_Index_By_Linenum(v:beval_lnum)
    if fidx == -1
        return ''
    endif

    " Get the tag output line for the current tag
    let tidx = s:Tlist_Window_Get_Tag_Index(fidx, v:beval_lnum)
    if tidx == 0
        return ''
    endif

    " Get the tag search pattern and display it
    return s:Tlist_Get_Tag_Prototype(fidx, tidx)
endfunction

" Tlist_Window_Check_Width
" Check the width of the taglist window. For horizontally split windows, the
" 'winfixheight' option is used to fix the height of the window. For
" vertically split windows, Vim doesn't support the 'winfixwidth' option. So
" need to handle window width changes from this function.
function! s:Tlist_Window_Check_Width()
    let tlist_winnr = bufwinnr(g:TagList_title)
    if tlist_winnr == -1
        return
    endif

    let width = winwidth(tlist_winnr)
    if width != g:Tlist_WinWidth
        call s:Tlist_Log_Msg("Tlist_Window_Check_Width: Changing window " .
                    \ "width from " . width . " to " . g:Tlist_WinWidth)
        let save_winnr = winnr()
        if save_winnr != tlist_winnr
            call s:Tlist_Exe_Cmd_No_Acmds(tlist_winnr . 'wincmd w')
        endif
        exe 'vert resize ' . g:Tlist_WinWidth
        if save_winnr != tlist_winnr
            call s:Tlist_Exe_Cmd_No_Acmds('wincmd p')
        endif
    endif
endfunction

" Tlist_Window_Exit_Only_Window
" If the 'Tlist_Exit_OnlyWindow' option is set, then exit Vim if only the
" taglist window is present.
function! s:Tlist_Window_Exit_Only_Window()
    " Before quitting Vim, delete the taglist buffer so that
    " the '0 mark is correctly set to the previous buffer.
    if v:version < 700
	if winbufnr(2) == -1
	    bdelete
	    quit
	endif
    else
	if winbufnr(2) == -1
	    if tabpagenr('$') == 1
		" Only one tag page is present
		bdelete
		quit
	    else
		" More than one tab page is present. Close only the current
		" tab page
		close
	    endif
	endif
    endif
endfunction

" Tlist_Window_Init
" Set the default options for the taglist window
function! s:Tlist_Window_Init()
    call s:Tlist_Log_Msg('Tlist_Window_Init()')

    " The 'readonly' option should not be set for the taglist buffer.
    " If Vim is started as "view/gview" or if the ":view" command is
    " used, then the 'readonly' option is set for all the buffers.
    " Unset it for the taglist buffer
    setlocal noreadonly

    " Set the taglist buffer filetype to taglist
    setlocal filetype=taglist

    " Define taglist window element highlighting
    syntax match TagListComment '^" .*'
    syntax match TagListFileName '^[^" ].*$'
    syntax match TagListTitle '^  \S.*$'
    syntax match TagListTagScope  '\s\[.\{-\}\]$'

    " Define the highlighting only if colors are supported
    if has('gui_running') || &t_Co > 2
        " Colors to highlight various taglist window elements
        " If user defined highlighting group exists, then use them.
        " Otherwise, use default highlight groups.
        if hlexists('MyTagListTagName')
            highlight link TagListTagName MyTagListTagName
        else
            highlight default link TagListTagName Search
        endif
        " Colors to highlight comments and titles
        if hlexists('MyTagListComment')
            highlight link TagListComment MyTagListComment
        else
            highlight clear TagListComment
            highlight default link TagListComment Comment
        endif
        if hlexists('MyTagListTitle')
            highlight link TagListTitle MyTagListTitle
        else
            highlight clear TagListTitle
            highlight default link TagListTitle Title
        endif
        if hlexists('MyTagListFileName')
            highlight link TagListFileName MyTagListFileName
        else
            highlight clear TagListFileName
            highlight default TagListFileName guibg=Grey ctermbg=darkgray
                        \ guifg=white ctermfg=white
        endif
        if hlexists('MyTagListTagScope')
            highlight link TagListTagScope MyTagListTagScope
        else
            highlight clear TagListTagScope
            highlight default link TagListTagScope Identifier
        endif
    else
        highlight default TagListTagName term=reverse cterm=reverse
    endif

    " Folding related settings
    setlocal foldenable
    setlocal foldminlines=0
    setlocal foldmethod=manual
    setlocal foldlevel=9999
    if g:Tlist_Enable_Fold_Column
        setlocal foldcolumn=3
    else
        setlocal foldcolumn=0
    endif
    setlocal foldtext=v:folddashes.getline(v:foldstart)

    if s:tlist_app_name != "winmanager"
        " Mark buffer as scratch
        silent! setlocal buftype=nofile
        if s:tlist_app_name == "none"
            silent! setlocal bufhidden=delete
        endif
        silent! setlocal noswapfile
        " Due to a bug in Vim 6.0, the winbufnr() function fails for unlisted
        " buffers. So if the taglist buffer is unlisted, multiple taglist
        " windows will be opened. This bug is fixed in Vim 6.1 and above
        if v:version >= 601
            silent! setlocal nobuflisted
        endif
    endif

    silent! setlocal nowrap

    " If the 'number' option is set in the source window, it will affect the
    " taglist window. So forcefully disable 'number' option for the taglist
    " window
    silent! setlocal nonumber

    " Use fixed height when horizontally split window is used
    if g:Tlist_Use_Horiz_Window
        if v:version >= 602
            set winfixheight
        endif
    endif
    if !g:Tlist_Use_Horiz_Window && v:version >= 700
        set winfixwidth
    endif

    " Setup balloon evaluation to display tag prototype
    if v:version >= 700 && has('balloon_eval')
        setlocal balloonexpr=Tlist_Ballon_Expr()
        set ballooneval
    endif

    " Setup the cpoptions properly for the maps to work
    let old_cpoptions = &cpoptions
    set cpoptions&vim

    " Create buffer local mappings for jumping to the tags and sorting the list
    nnoremap <buffer> <silent> <CR>
                \ :call <SID>Tlist_Window_Jump_To_Tag('useopen')<CR>
    nnoremap <buffer> <silent> o
                \ :call <SID>Tlist_Window_Jump_To_Tag('newwin')<CR>
    nnoremap <buffer> <silent> p
                \ :call <SID>Tlist_Window_Jump_To_Tag('preview')<CR>
    nnoremap <buffer> <silent> P
                \ :call <SID>Tlist_Window_Jump_To_Tag('prevwin')<CR>
    if v:version >= 700
    nnoremap <buffer> <silent> t
                \ :call <SID>Tlist_Window_Jump_To_Tag('checktab')<CR>
    nnoremap <buffer> <silent> <C-t>
                \ :call <SID>Tlist_Window_Jump_To_Tag('newtab')<CR>
    endif
    nnoremap <buffer> <silent> <2-LeftMouse>
                \ :call <SID>Tlist_Window_Jump_To_Tag('useopen')<CR>
    nnoremap <buffer> <silent> s
                \ :call <SID>Tlist_Change_Sort('cmd', 'toggle', '')<CR>
    nnoremap <buffer> <silent> + :silent! foldopen<CR>
    nnoremap <buffer> <silent> - :silent! foldclose<CR>
    nnoremap <buffer> <silent> * :silent! %foldopen!<CR>
    nnoremap <buffer> <silent> = :silent! %foldclose<CR>
    nnoremap <buffer> <silent> <kPlus> :silent! foldopen<CR>
    nnoremap <buffer> <silent> <kMinus> :silent! foldclose<CR>
    nnoremap <buffer> <silent> <kMultiply> :silent! %foldopen!<CR>
    nnoremap <buffer> <silent> <Space> :call <SID>Tlist_Window_Show_Info()<CR>
    nnoremap <buffer> <silent> u :call <SID>Tlist_Window_Update_File()<CR>
    nnoremap <buffer> <silent> d :call <SID>Tlist_Remove_File(-1, 1)<CR>
    nnoremap <buffer> <silent> x :call <SID>Tlist_Window_Zoom()<CR>
    nnoremap <buffer> <silent> [[ :call <SID>Tlist_Window_Move_To_File(-1)<CR>
    nnoremap <buffer> <silent> <BS> :call <SID>Tlist_Window_Move_To_File(-1)<CR>
    nnoremap <buffer> <silent> ]] :call <SID>Tlist_Window_Move_To_File(1)<CR>
    nnoremap <buffer> <silent> <Tab> :call <SID>Tlist_Window_Move_To_File(1)<CR>
    nnoremap <buffer> <silent> <F1> :call <SID>Tlist_Window_Toggle_Help_Text()<CR>
    nnoremap <buffer> <silent> q :close<CR>

    " Insert mode mappings
    inoremap <buffer> <silent> <CR>
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('useopen')<CR>
    " Windows needs return
    inoremap <buffer> <silent> <Return>
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('useopen')<CR>
    inoremap <buffer> <silent> o
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('newwin')<CR>
    inoremap <buffer> <silent> p
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('preview')<CR>
    inoremap <buffer> <silent> P
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('prevwin')<CR>
    if v:version >= 700
    inoremap <buffer> <silent> t
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('checktab')<CR>
    inoremap <buffer> <silent> <C-t>
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('newtab')<CR>
    endif
    inoremap <buffer> <silent> <2-LeftMouse>
                \ <C-o>:call <SID>Tlist_Window_Jump_To_Tag('useopen')<CR>
    inoremap <buffer> <silent> s
                \ <C-o>:call <SID>Tlist_Change_Sort('cmd', 'toggle', '')<CR>
    inoremap <buffer> <silent> +             <C-o>:silent! foldopen<CR>
    inoremap <buffer> <silent> -             <C-o>:silent! foldclose<CR>
    inoremap <buffer> <silent> *             <C-o>:silent! %foldopen!<CR>
    inoremap <buffer> <silent> =             <C-o>:silent! %foldclose<CR>
    inoremap <buffer> <silent> <kPlus>       <C-o>:silent! foldopen<CR>
    inoremap <buffer> <silent> <kMinus>      <C-o>:silent! foldclose<CR>
    inoremap <buffer> <silent> <kMultiply>   <C-o>:silent! %foldopen!<CR>
    inoremap <buffer> <silent> <Space>       <C-o>:call
                                    \ <SID>Tlist_Window_Show_Info()<CR>
    inoremap <buffer> <silent> u
                            \ <C-o>:call <SID>Tlist_Window_Update_File()<CR>
    inoremap <buffer> <silent> d    <C-o>:call <SID>Tlist_Remove_File(-1, 1)<CR>
    inoremap <buffer> <silent> x    <C-o>:call <SID>Tlist_Window_Zoom()<CR>
    inoremap <buffer> <silent> [[   <C-o>:call <SID>Tlist_Window_Move_To_File(-1)<CR>
    inoremap <buffer> <silent> <BS> <C-o>:call <SID>Tlist_Window_Move_To_File(-1)<CR>
    inoremap <buffer> <silent> ]]   <C-o>:call <SID>Tlist_Window_Move_To_File(1)<CR>
    inoremap <buffer> <silent> <Tab> <C-o>:call <SID>Tlist_Window_Move_To_File(1)<CR>
    inoremap <buffer> <silent> <F1>  <C-o>:call <SID>Tlist_Window_Toggle_Help_Text()<CR>
    inoremap <buffer> <silent> q    <C-o>:close<CR>

    " Map single left mouse click if the user wants this functionality
    if g:Tlist_Use_SingleClick == 1
        " Contributed by Bindu Wavell
        " attempt to perform single click mapping, it would be much
        " nicer if we could nnoremap <buffer> ... however vim does
        " not fire the <buffer> <leftmouse> when you use the mouse
        " to enter a buffer.
        let clickmap = ':if bufname("%") =~ "__Tag_List__" <bar> ' .
                    \ 'call <SID>Tlist_Window_Jump_To_Tag("useopen") ' .
                    \ '<bar> endif <CR>'
        if maparg('<leftmouse>', 'n') == ''
            " no mapping for leftmouse
            exe ':nnoremap <silent> <leftmouse> <leftmouse>' . clickmap
        else
            " we have a mapping
            let mapcmd = ':nnoremap <silent> <leftmouse> <leftmouse>'
            let mapcmd = mapcmd . substitute(substitute(
                        \ maparg('<leftmouse>', 'n'), '|', '<bar>', 'g'),
                        \ '\c^<leftmouse>', '', '')
            let mapcmd = mapcmd . clickmap
            exe mapcmd
        endif
    endif

    " Define the taglist autocommands
    augroup TagListAutoCmds
        autocmd!
        " Display the tag prototype for the tag under the cursor.
        autocmd CursorHold __Tag_List__ call s:Tlist_Window_Show_Info()
        " Highlight the current tag periodically
        autocmd CursorHold * silent call s:Tlist_Window_Highlight_Tag(
                            \ fnamemodify(bufname('%'), ':p'), line('.'), 1, 0)

        " Adjust the Vim window width when taglist window is closed
        autocmd BufUnload __Tag_List__ call s:Tlist_Post_Close_Cleanup()
        " Close the fold for this buffer when leaving the buffer
        if g:Tlist_File_Fold_Auto_Close
            autocmd BufEnter * silent
                \ call s:Tlist_Window_Open_File_Fold(expand('<abuf>'))
        endif
        " Exit Vim itself if only the taglist window is present (optional)
        if g:Tlist_Exit_OnlyWindow
	    autocmd BufEnter __Tag_List__ nested
			\ call s:Tlist_Window_Exit_Only_Window()
        endif
        if s:tlist_app_name != "winmanager" &&
                    \ !g:Tlist_Process_File_Always &&
                    \ (!has('gui_running') || !g:Tlist_Show_Menu)
            " Auto refresh the taglist window
            autocmd BufEnter * call s:Tlist_Refresh()
        endif

        if !g:Tlist_Use_Horiz_Window
            if v:version < 700
                autocmd WinEnter * call s:Tlist_Window_Check_Width()
            endif
        endif
        if v:version >= 700
            autocmd TabEnter * silent call s:Tlist_Refresh_Folds()
        endif
    augroup end

    " Restore the previous cpoptions settings
    let &cpoptions = old_cpoptions
endfunction

" Tlist_Window_Refresh
" Display the tags for all the files in the taglist window
function! s:Tlist_Window_Refresh()
    call s:Tlist_Log_Msg('Tlist_Window_Refresh()')
    " Set report option to a huge value to prevent informational messages
    " while deleting the lines
    let old_report = &report
    set report=99999

    " Mark the buffer as modifiable
    setlocal modifiable

    " Delete the contents of the buffer to the black-hole register
    silent! %delete _

    " As we have cleared the taglist window, mark all the files
    " as not visible
    let i = 0
    while i < s:tlist_file_count
        let s:tlist_{i}_visible = 0
        let i = i + 1
    endwhile

    if g:Tlist_Compact_Format == 0
        " Display help in non-compact mode
        call s:Tlist_Window_Display_Help()
    endif

    " Mark the buffer as not modifiable
    setlocal nomodifiable

    " Restore the report option
    let &report = old_report

    " If the tags for only one file should be displayed in the taglist
    " window, then no need to add the tags here. The bufenter autocommand
    " will add the tags for that file.
    if g:Tlist_Show_One_File
        return
    endif

    " List all the tags for the previously processed files
    " Do this only if taglist is configured to display tags for more than
    " one file. Otherwise, when Tlist_Show_One_File is configured,
    " tags for the wrong file will be displayed.
    let i = 0
    while i < s:tlist_file_count
        call s:Tlist_Window_Refresh_File(s:tlist_{i}_filename,
                    \ s:tlist_{i}_filetype)
        let i = i + 1
    endwhile

    if g:Tlist_Auto_Update
        " Add and list the tags for all buffers in the Vim buffer list
        let i = 1
        let last_bufnum = bufnr('$')
        while i <= last_bufnum
            if buflisted(i)
                let fname = fnamemodify(bufname(i), ':p')
                let ftype = s:Tlist_Get_Buffer_Filetype(i)
                " If the file doesn't support tag listing, skip it
                if !s:Tlist_Skip_File(fname, ftype)
                    call s:Tlist_Window_Refresh_File(fname, ftype)
                endif
            endif
            let i = i + 1
        endwhile
    endif

    " If Tlist_File_Fold_Auto_Close option is set, then close all the folds
    if g:Tlist_File_Fold_Auto_Close
        " Close all the folds
        silent! %foldclose
    endif

    " Move the cursor to the top of the taglist window
    normal! gg
endfunction

" Tlist_Post_Close_Cleanup()
" Close the taglist window and adjust the Vim window width
function! s:Tlist_Post_Close_Cleanup()
    call s:Tlist_Log_Msg('Tlist_Post_Close_Cleanup()')
    " Mark all the files as not visible
    let i = 0
    while i < s:tlist_file_count
        let s:tlist_{i}_visible = 0
        let i = i + 1
    endwhile

    " Remove the taglist autocommands
    silent! autocmd! TagListAutoCmds

    " Clear all the highlights
    match none

    silent! syntax clear TagListTitle
    silent! syntax clear TagListComment
    silent! syntax clear TagListTagScope

    " Remove the left mouse click mapping if it was setup initially
    if g:Tlist_Use_SingleClick
        if hasmapto('<LeftMouse>')
            nunmap <LeftMouse>
        endif
    endif

    if s:tlist_app_name != "winmanager"
    if g:Tlist_Use_Horiz_Window || g:Tlist_Inc_Winwidth == 0 ||
                \ s:tlist_winsize_chgd != 1 ||
                \ &columns < (80 + g:Tlist_WinWidth)
        " No need to adjust window width if using horizontally split taglist
        " window or if columns is less than 101 or if the user chose not to
        " adjust the window width
    else
        " If the user didn't manually move the window, then restore the window
        " position to the pre-taglist position
        if s:tlist_pre_winx != -1 && s:tlist_pre_winy != -1 &&
                    \ getwinposx() == s:tlist_winx &&
                    \ getwinposy() == s:tlist_winy
            exe 'winpos ' . s:tlist_pre_winx . ' ' . s:tlist_pre_winy
        endif

        " Adjust the Vim window width
        let &columns= &columns - (g:Tlist_WinWidth + 1)
    endif
    endif

    let s:tlist_winsize_chgd = -1

    " Reset taglist state variables
    if s:tlist_app_name == "winmanager"
        let s:tlist_app_name = "none"
    endif
    let s:tlist_window_initialized = 0
endfunction

" Tlist_Window_Refresh_File()
" List the tags defined in the specified file in a Vim window
function! s:Tlist_Window_Refresh_File(filename, ftype)
    call s:Tlist_Log_Msg('Tlist_Window_Refresh_File (' . a:filename . ')')
    " First check whether the file already exists
    let fidx = s:Tlist_Get_File_Index(a:filename)
    if fidx != -1
        let file_listed = 1
    else
        let file_listed = 0
    endif

    if !file_listed
        " Check whether this file is removed based on user request
        " If it is, then don't display the tags for this file
        if s:Tlist_User_Removed_File(a:filename)
            return
        endif
    endif

    if file_listed && s:tlist_{fidx}_visible
        " Check whether the file tags are currently valid
        if s:tlist_{fidx}_valid
            " Goto the first line in the file
            exe s:tlist_{fidx}_start

            " If the line is inside a fold, open the fold
            if foldclosed('.') != -1
                exe "silent! " . s:tlist_{fidx}_start . "," .
                            \ s:tlist_{fidx}_end . "foldopen!"
            endif
            return
        endif

        " Discard and remove the tags for this file from display
        call s:Tlist_Discard_TagInfo(fidx)
        call s:Tlist_Window_Remove_File_From_Display(fidx)
    endif

    " Process and generate a list of tags defined in the file
    if !file_listed || !s:tlist_{fidx}_valid
        let ret_fidx = s:Tlist_Process_File(a:filename, a:ftype)
        if ret_fidx == -1
            return
        endif
        let fidx = ret_fidx
    endif

    " Set report option to a huge value to prevent informational messages
    " while adding lines to the taglist window
    let old_report = &report
    set report=99999

    if g:Tlist_Show_One_File
        " Remove the previous file
        if s:tlist_cur_file_idx != -1
            call s:Tlist_Window_Remove_File_From_Display(s:tlist_cur_file_idx)
            let s:tlist_{s:tlist_cur_file_idx}_visible = 0
            let s:tlist_{s:tlist_cur_file_idx}_start = 0
            let s:tlist_{s:tlist_cur_file_idx}_end = 0
        endif
        let s:tlist_cur_file_idx = fidx
    endif

    " Mark the buffer as modifiable
    setlocal modifiable

    " Add new files to the end of the window. For existing files, add them at
    " the same line where they were previously present. If the file is not
    " visible, then add it at the end
    if s:tlist_{fidx}_start == 0 || !s:tlist_{fidx}_visible
        if g:Tlist_Compact_Format
            let s:tlist_{fidx}_start = line('$')
        else
            let s:tlist_{fidx}_start = line('$') + 1
        endif
    endif

    let s:tlist_{fidx}_visible = 1

    " Goto the line where this file should be placed
    if g:Tlist_Compact_Format
        exe s:tlist_{fidx}_start
    else
        exe s:tlist_{fidx}_start - 1
    endif

    let txt = fnamemodify(s:tlist_{fidx}_filename, ':t') . ' (' .
                \ fnamemodify(s:tlist_{fidx}_filename, ':p:h') . ')'
    if g:Tlist_Compact_Format == 0
        silent! put =txt
    else
        silent! put! =txt
        " Move to the next line
        exe line('.') + 1
    endif
    let file_start = s:tlist_{fidx}_start

    " Add the tag names grouped by tag type to the buffer with a title
    let i = 1
    let ttype_cnt = s:tlist_{a:ftype}_count
    while i <= ttype_cnt
        let ttype = s:tlist_{a:ftype}_{i}_name
        " Add the tag type only if there are tags for that type
        let fidx_ttype = 's:tlist_' . fidx . '_' . ttype
        let ttype_txt = {fidx_ttype}
        if ttype_txt != ''
            let txt = '  ' . s:tlist_{a:ftype}_{i}_fullname
            if g:Tlist_Compact_Format == 0
                let ttype_start_lnum = line('.') + 1
                silent! put =txt
            else
                let ttype_start_lnum = line('.')
                silent! put! =txt
            endif
            silent! put =ttype_txt

            let {fidx_ttype}_offset = ttype_start_lnum - file_start

            " create a fold for this tag type
            let fold_start = ttype_start_lnum
            let fold_end = fold_start + {fidx_ttype}_count
            exe fold_start . ',' . fold_end  . 'fold'

            " Adjust the cursor position
            if g:Tlist_Compact_Format == 0
                exe ttype_start_lnum + {fidx_ttype}_count
            else
                exe ttype_start_lnum + {fidx_ttype}_count + 1
            endif

            if g:Tlist_Compact_Format == 0
                " Separate the tag types by a empty line
                silent! put =''
            endif
        endif
        let i = i + 1
    endwhile

    if s:tlist_{fidx}_tag_count == 0
        if g:Tlist_Compact_Format == 0
            silent! put =''
        endif
    endif

    let s:tlist_{fidx}_end = line('.') - 1

    " Create a fold for the entire file
    exe s:tlist_{fidx}_start . ',' . s:tlist_{fidx}_end . 'fold'
    exe 'silent! ' . s:tlist_{fidx}_start . ',' .
                \ s:tlist_{fidx}_end . 'foldopen!'

    " Goto the starting line for this file,
    exe s:tlist_{fidx}_start

    if s:tlist_app_name == "winmanager"
        " To handle a bug in the winmanager plugin, add a space at the
        " last line
        call setline('$', ' ')
    endif

    " Mark the buffer as not modifiable
    setlocal nomodifiable

    " Restore the report option
    let &report = old_report

    " Update the start and end line numbers for all the files following this
    " file
    let start = s:tlist_{fidx}_start
    " include the empty line after the last line
    if g:Tlist_Compact_Format
        let end = s:tlist_{fidx}_end
    else
        let end = s:tlist_{fidx}_end + 1
    endif
    call s:Tlist_Window_Update_Line_Offsets(fidx + 1, 1, end - start + 1)

    " Now that we have updated the taglist window, update the tags
    " menu (if present)
    if g:Tlist_Show_Menu
        call s:Tlist_Menu_Update_File(1)
    endif
endfunction

" Tlist_Init_File
" Initialize the variables for a new file
function! s:Tlist_Init_File(filename, ftype)
    call s:Tlist_Log_Msg('Tlist_Init_File (' . a:filename . ')')
    " Add new files at the end of the list
    let fidx = s:tlist_file_count
    let s:tlist_file_count = s:tlist_file_count + 1
    " Add the new file name to the taglist list of file names
    let s:tlist_file_names = s:tlist_file_names . a:filename . "\n"

    " Initialize the file variables
    let s:tlist_{fidx}_filename = a:filename
    let s:tlist_{fidx}_sort_type = g:Tlist_Sort_Type
    let s:tlist_{fidx}_filetype = a:ftype
    let s:tlist_{fidx}_mtime = -1
    let s:tlist_{fidx}_start = 0
    let s:tlist_{fidx}_end = 0
    let s:tlist_{fidx}_valid = 0
    let s:tlist_{fidx}_visible = 0
    let s:tlist_{fidx}_tag_count = 0
    let s:tlist_{fidx}_menu_cmd = ''

    " Initialize the tag type variables
    let i = 1
    while i <= s:tlist_{a:ftype}_count
        let ttype = s:tlist_{a:ftype}_{i}_name
        let s:tlist_{fidx}_{ttype} = ''
        let s:tlist_{fidx}_{ttype}_offset = 0
        let s:tlist_{fidx}_{ttype}_count = 0
        let i = i + 1
    endwhile

    return fidx
endfunction

" Tlist_Get_Tag_Type_By_Tag
" Return the tag type for the specified tag index
function! s:Tlist_Get_Tag_Type_By_Tag(fidx, tidx)
    let ttype_var = 's:tlist_' . a:fidx . '_' . a:tidx . '_tag_type'

    " Already parsed and have the tag name
    if exists(ttype_var)
        return {ttype_var}
    endif

    let tag_line = s:tlist_{a:fidx}_{a:tidx}_tag
    let {ttype_var} = s:Tlist_Extract_Tagtype(tag_line)

    return {ttype_var}
endfunction

" Tlist_Get_Tag_Prototype
function! s:Tlist_Get_Tag_Prototype(fidx, tidx)
    let tproto_var = 's:tlist_' . a:fidx . '_' . a:tidx . '_tag_proto'

    " Already parsed and have the tag prototype
    if exists(tproto_var)
        return {tproto_var}
    endif

    " Parse and extract the tag prototype
    let tag_line = s:tlist_{a:fidx}_{a:tidx}_tag
    let start = stridx(tag_line, '/^') + 2
    let end = stridx(tag_line, '/;"' . "\t")
    if tag_line[end - 1] == '$'
        let end = end -1
    endif
    let tag_proto = strpart(tag_line, start, end - start)
    let {tproto_var} = substitute(tag_proto, '\s*', '', '')

    return {tproto_var}
endfunction

" Tlist_Get_Tag_SearchPat
function! s:Tlist_Get_Tag_SearchPat(fidx, tidx)
    let tpat_var = 's:tlist_' . a:fidx . '_' . a:tidx . '_tag_searchpat'

    " Already parsed and have the tag search pattern
    if exists(tpat_var)
        return {tpat_var}
    endif

    " Parse and extract the tag search pattern
    let tag_line = s:tlist_{a:fidx}_{a:tidx}_tag
    let start = stridx(tag_line, '/^') + 2
    let end = stridx(tag_line, '/;"' . "\t")
    if tag_line[end - 1] == '$'
        let end = end -1
    endif
    let {tpat_var} = '\V\^' . strpart(tag_line, start, end - start) .
                        \ (tag_line[end] == '$' ? '\$' : '')

    return {tpat_var}
endfunction

" Tlist_Get_Tag_Linenum
" Return the tag line number, given the tag index
function! s:Tlist_Get_Tag_Linenum(fidx, tidx)
    let tline_var = 's:tlist_' . a:fidx . '_' . a:tidx . '_tag_linenum'

    " Already parsed and have the tag line number
    if exists(tline_var)
        return {tline_var}
    endif

    " Parse and extract the tag line number
    let tag_line = s:tlist_{a:fidx}_{a:tidx}_tag
    let start = strridx(tag_line, 'line:') + 5
    let end = strridx(tag_line, "\t")
    if end < start
        let {tline_var} = strpart(tag_line, start) + 0
    else
        let {tline_var} = strpart(tag_line, start, end - start) + 0
    endif

    return {tline_var}
endfunction

" Tlist_Parse_Tagline
" Parse a tag line from the ctags output. Separate the tag output based on the
" tag type and store it in the tag type variable.
" The format of each line in the ctags output is:
"
"     tag_name<TAB>file_name<TAB>ex_cmd;"<TAB>extension_fields
"
function! s:Tlist_Parse_Tagline(tag_line)
    if a:tag_line == ''
        " Skip empty lines
        return
    endif

    " Extract the tag type
    let ttype = s:Tlist_Extract_Tagtype(a:tag_line)

    " Make sure the tag type is a valid and supported one
    if ttype == '' || stridx(s:ctags_flags, ttype) == -1
        " Line is not in proper tags format or Tag type is not supported
        return
    endif

    " Update the total tag count
    let s:tidx = s:tidx + 1

    " The following variables are used to optimize this code.  Vim is slow in
    " using curly brace names. To reduce the amount of processing needed, the
    " curly brace variables are pre-processed here
    let fidx_tidx = 's:tlist_' . s:fidx . '_' . s:tidx
    let fidx_ttype = 's:tlist_' . s:fidx . '_' . ttype

    " Update the count of this tag type
    let ttype_idx = {fidx_ttype}_count + 1
    let {fidx_ttype}_count = ttype_idx

    " Store the ctags output for this tag
    let {fidx_tidx}_tag = a:tag_line

    " Store the tag index and the tag type index (back pointers)
    let {fidx_ttype}_{ttype_idx} = s:tidx
    let {fidx_tidx}_ttype_idx = ttype_idx

    " Extract the tag name
    let tag_name = strpart(a:tag_line, 0, stridx(a:tag_line, "\t"))

    " Extract the tag scope/prototype
    if g:Tlist_Display_Prototype
        let ttxt = '    ' . s:Tlist_Get_Tag_Prototype(s:fidx, s:tidx)
    else
        let ttxt = '    ' . tag_name

        " Add the tag scope, if it is available and is configured. Tag
        " scope is the last field after the 'line:<num>\t' field
        if g:Tlist_Display_Tag_Scope
            let tag_scope = s:Tlist_Extract_Tag_Scope(a:tag_line)
            if tag_scope != ''
                let ttxt = ttxt . ' [' . tag_scope . ']'
            endif
        endif
    endif

    " Add this tag to the tag type variable
    let {fidx_ttype} = {fidx_ttype} . ttxt . "\n"

    " Save the tag name
    let {fidx_tidx}_tag_name = tag_name
endfunction

" Tlist_Process_File
" Get the list of tags defined in the specified file and store them
" in Vim variables. Returns the file index where the tags are stored.
function! s:Tlist_Process_File(filename, ftype)
    call s:Tlist_Log_Msg('Tlist_Process_File (' . a:filename . ', ' .
                \ a:ftype . ')')
    " Check whether this file is supported
    if s:Tlist_Skip_File(a:filename, a:ftype)
        return -1
    endif

    " If the tag types for this filetype are not yet created, then create
    " them now
    let var = 's:tlist_' . a:ftype . '_count'
    if !exists(var)
        if s:Tlist_FileType_Init(a:ftype) == 0
            return -1
        endif
    endif

    " If this file is already processed, then use the cached values
    let fidx = s:Tlist_Get_File_Index(a:filename)
    if fidx == -1
        " First time, this file is loaded
        let fidx = s:Tlist_Init_File(a:filename, a:ftype)
    else
        " File was previously processed. Discard the tag information
        call s:Tlist_Discard_TagInfo(fidx)
    endif

    let s:tlist_{fidx}_valid = 1

    " Exuberant ctags arguments to generate a tag list
    let ctags_args = ' -f - --format=2 --excmd=pattern --fields=nks '

    " Form the ctags argument depending on the sort type
    if s:tlist_{fidx}_sort_type == 'name'
        let ctags_args = ctags_args . '--sort=yes'
    else
        let ctags_args = ctags_args . '--sort=no'
    endif

    " Add the filetype specific arguments
    let ctags_args = ctags_args . ' ' . s:tlist_{a:ftype}_ctags_args

    " Ctags command to produce output with regexp for locating the tags
    let ctags_cmd = g:Tlist_Ctags_Cmd . ctags_args
    let ctags_cmd = ctags_cmd . ' "' . a:filename . '"'

    if &shellxquote == '"'
        " Double-quotes within double-quotes will not work in the
        " command-line.If the 'shellxquote' option is set to double-quotes,
        " then escape the double-quotes in the ctags command-line.
        let ctags_cmd = escape(ctags_cmd, '"')
    endif

    " In Windows 95, if not using cygwin, disable the 'shellslash'
    " option. Otherwise, this will cause problems when running the
    " ctags command.
    if has('win95') && !has('win32unix')
        let old_shellslash = &shellslash
        set noshellslash
    endif

    if has('win32') && !has('win32unix') && !has('win95')
                \ && (&shell =~ 'cmd.exe')
        " Windows does not correctly deal with commands that have more than 1
        " set of double quotes.  It will strip them all resulting in:
        " 'C:\Program' is not recognized as an internal or external command
        " operable program or batch file.  To work around this, place the
        " command inside a batch file and call the batch file.
        " Do this only on Win2K, WinXP and above.
        " Contributed by: David Fishburn.
        let s:taglist_tempfile = fnamemodify(tempname(), ':h') .
                    \ '\taglist.cmd'
        exe 'redir! > ' . s:taglist_tempfile
        silent echo ctags_cmd
        redir END

        call s:Tlist_Log_Msg('Cmd inside batch file: ' . ctags_cmd)
        let ctags_cmd = '"' . s:taglist_tempfile . '"'
    endif

    call s:Tlist_Log_Msg('Cmd: ' . ctags_cmd)

    " Run ctags and get the tag list
    let cmd_output = system(ctags_cmd)

    " Restore the value of the 'shellslash' option.
    if has('win95') && !has('win32unix')
        let &shellslash = old_shellslash
    endif

    if exists('s:taglist_tempfile')
        " Delete the temporary cmd file created on MS-Windows
        call delete(s:taglist_tempfile)
    endif

    " Handle errors
    if v:shell_error
        let msg = "Taglist: Failed to generate tags for " . a:filename
        call s:Tlist_Warning_Msg(msg)
        if cmd_output != ''
            call s:Tlist_Warning_Msg(cmd_output)
        endif
        return fidx
    endif

    " Store the modification time for the file
    let s:tlist_{fidx}_mtime = getftime(a:filename)

    " No tags for current file
    if cmd_output == ''
        call s:Tlist_Log_Msg('No tags defined in ' . a:filename)
        return fidx
    endif

    call s:Tlist_Log_Msg('Generated tags information for ' . a:filename)

    if v:version > 601
        " The following script local variables are used by the
        " Tlist_Parse_Tagline() function.
        let s:ctags_flags = s:tlist_{a:ftype}_ctags_flags
        let s:fidx = fidx
        let s:tidx = 0

        " Process the ctags output one line at a time.  The substitute()
        " command is used to parse the tag lines instead of using the
        " matchstr()/stridx()/strpart() functions for performance reason
        call substitute(cmd_output, "\\([^\n]\\+\\)\n",
                    \ '\=s:Tlist_Parse_Tagline(submatch(1))', 'g')

        " Save the number of tags for this file
        let s:tlist_{fidx}_tag_count = s:tidx

        " The following script local variables are no longer needed
        unlet! s:ctags_flags
        unlet! s:tidx
        unlet! s:fidx
    else
        " Due to a bug in Vim earlier than version 6.1,
        " we cannot use substitute() to parse the ctags output.
        " Instead the slow str*() functions are used
        let ctags_flags = s:tlist_{a:ftype}_ctags_flags
        let tidx = 0

        while cmd_output != ''
            " Extract one line at a time
            let idx = stridx(cmd_output, "\n")
            let one_line = strpart(cmd_output, 0, idx)
            " Remove the line from the tags output
            let cmd_output = strpart(cmd_output, idx + 1)

            if one_line == ''
                " Line is not in proper tags format
                continue
            endif

            " Extract the tag type
            let ttype = s:Tlist_Extract_Tagtype(one_line)

            " Make sure the tag type is a valid and supported one
            if ttype == '' || stridx(ctags_flags, ttype) == -1
                " Line is not in proper tags format or Tag type is not
                " supported
                continue
            endif

            " Update the total tag count
            let tidx = tidx + 1

            " The following variables are used to optimize this code.  Vim is
            " slow in using curly brace names. To reduce the amount of
            " processing needed, the curly brace variables are pre-processed
            " here
            let fidx_tidx = 's:tlist_' . fidx . '_' . tidx
            let fidx_ttype = 's:tlist_' . fidx . '_' . ttype

            " Update the count of this tag type
            let ttype_idx = {fidx_ttype}_count + 1
            let {fidx_ttype}_count = ttype_idx

            " Store the ctags output for this tag
            let {fidx_tidx}_tag = one_line

            " Store the tag index and the tag type index (back pointers)
            let {fidx_ttype}_{ttype_idx} = tidx
            let {fidx_tidx}_ttype_idx = ttype_idx

            " Extract the tag name
            let tag_name = strpart(one_line, 0, stridx(one_line, "\t"))

            " Extract the tag scope/prototype
            if g:Tlist_Display_Prototype
                let ttxt = '    ' . s:Tlist_Get_Tag_Prototype(fidx, tidx)
            else
                let ttxt = '    ' . tag_name

                " Add the tag scope, if it is available and is configured. Tag
                " scope is the last field after the 'line:<num>\t' field
                if g:Tlist_Display_Tag_Scope
                    let tag_scope = s:Tlist_Extract_Tag_Scope(one_line)
                    if tag_scope != ''
                        let ttxt = ttxt . ' [' . tag_scope . ']'
                    endif
                endif
            endif

            " Add this tag to the tag type variable
            let {fidx_ttype} = {fidx_ttype} . ttxt . "\n"

            " Save the tag name
            let {fidx_tidx}_tag_name = tag_name
        endwhile

        " Save the number of tags for this file
        let s:tlist_{fidx}_tag_count = tidx
    endif

    call s:Tlist_Log_Msg('Processed ' . s:tlist_{fidx}_tag_count . 
                \ ' tags in ' . a:filename)

    return fidx
endfunction

" Tlist_Update_File
" Update the tags for a file (if needed)
function! Tlist_Update_File(filename, ftype)
    call s:Tlist_Log_Msg('Tlist_Update_File (' . a:filename . ')')
    " If the file doesn't support tag listing, skip it
    if s:Tlist_Skip_File(a:filename, a:ftype)
        return
    endif

    " Convert the file name to a full path
    let fname = fnamemodify(a:filename, ':p')

    " First check whether the file already exists
    let fidx = s:Tlist_Get_File_Index(fname)

    if fidx != -1 && s:tlist_{fidx}_valid
        " File exists and the tags are valid
        " Check whether the file was modified after the last tags update
        " If it is modified, then update the tags
        if s:tlist_{fidx}_mtime == getftime(fname)
            return
        endif
    else
        " If the tags were removed previously based on a user request,
        " as we are going to update the tags (based on the user request),
        " remove the filename from the deleted list
        call s:Tlist_Update_Remove_List(fname, 0)
    endif

    " If the taglist window is opened, update it
    let winnum = bufwinnr(g:TagList_title)
    if winnum == -1
        " Taglist window is not present. Just update the taglist
        " and return
        call s:Tlist_Process_File(fname, a:ftype)
    else
        if g:Tlist_Show_One_File && s:tlist_cur_file_idx != -1
            " If tags for only one file are displayed and we are not
            " updating the tags for that file, then no need to
            " refresh the taglist window. Otherwise, the taglist
            " window should be updated.
            if s:tlist_{s:tlist_cur_file_idx}_filename != fname
                call s:Tlist_Process_File(fname, a:ftype)
                return
            endif
        endif

        " Save the current window number
        let save_winnr = winnr()

        " Goto the taglist window
        call s:Tlist_Window_Goto_Window()

        " Save the cursor position
        let save_line = line('.')
        let save_col = col('.')

        " Update the taglist window
        call s:Tlist_Window_Refresh_File(fname, a:ftype)

        " Restore the cursor position
        if v:version >= 601
            call cursor(save_line, save_col)
        else
            exe save_line
            exe 'normal! ' . save_col . '|'
        endif

        if winnr() != save_winnr
            " Go back to the original window
            call s:Tlist_Exe_Cmd_No_Acmds(save_winnr . 'wincmd w')
        endif
    endif

    " Update the taglist menu
    if g:Tlist_Show_Menu
        call s:Tlist_Menu_Update_File(1)
    endif
endfunction

" Tlist_Window_Close
" Close the taglist window
function! s:Tlist_Window_Close()
    call s:Tlist_Log_Msg('Tlist_Window_Close()')
    " Make sure the taglist window exists
    let winnum = bufwinnr(g:TagList_title)
    if winnum == -1
        call s:Tlist_Warning_Msg('Error: Taglist window is not open')
        return
    endif

    if winnr() == winnum
        " Already in the taglist window. Close it and return
        if winbufnr(2) != -1
            " If a window other than the taglist window is open,
            " then only close the taglist window.
            close
        endif
    else
        " Goto the taglist window, close it and then come back to the
        " original window
        let curbufnr = bufnr('%')
        exe winnum . 'wincmd w'
        close
        " Need to jump back to the original window only if we are not
        " already in that window
        let winnum = bufwinnr(curbufnr)
        if winnr() != winnum
            exe winnum . 'wincmd w'
        endif
    endif
endfunction

" Tlist_Window_Mark_File_Window
" Mark the current window as the file window to use when jumping to a tag.
" Only if the current window is a non-plugin, non-preview and non-taglist
" window
function! s:Tlist_Window_Mark_File_Window()
    if getbufvar('%', '&buftype') == '' && !&previewwindow
        let w:tlist_file_window = "yes"
    endif
endfunction

" Tlist_Window_Open
" Open and refresh the taglist window
function! s:Tlist_Window_Open()
    call s:Tlist_Log_Msg('Tlist_Window_Open()')
    " If the window is open, jump to it
    let winnum = bufwinnr(g:TagList_title)
    if winnum != -1
        " Jump to the existing window
        if winnr() != winnum
            exe winnum . 'wincmd w'
        endif
        return
    endif

    if s:tlist_app_name == "winmanager"
        " Taglist plugin is no longer part of the winmanager app
        let s:tlist_app_name = "none"
    endif

    " Get the filename and filetype for the specified buffer
    let curbuf_name = fnamemodify(bufname('%'), ':p')
    let curbuf_ftype = s:Tlist_Get_Buffer_Filetype('%')
    let cur_lnum = line('.')

    " Mark the current window as the desired window to open a file when a tag
    " is selected.
    call s:Tlist_Window_Mark_File_Window()

    " Open the taglist window
    call s:Tlist_Window_Create()

    call s:Tlist_Window_Refresh()

    if g:Tlist_Show_One_File
        " Add only the current buffer and file
        "
        " If the file doesn't support tag listing, skip it
        if !s:Tlist_Skip_File(curbuf_name, curbuf_ftype)
            call s:Tlist_Window_Refresh_File(curbuf_name, curbuf_ftype)
        endif
    endif

    if g:Tlist_File_Fold_Auto_Close
        " Open the fold for the current file, as all the folds in
        " the taglist window are closed
        let fidx = s:Tlist_Get_File_Index(curbuf_name)
        if fidx != -1
            exe "silent! " . s:tlist_{fidx}_start . "," .
                        \ s:tlist_{fidx}_end . "foldopen!"
        endif
    endif

    " Highlight the current tag
    call s:Tlist_Window_Highlight_Tag(curbuf_name, cur_lnum, 1, 1)
endfunction

" Tlist_Window_Toggle()
" Open or close a taglist window
function! s:Tlist_Window_Toggle()
    call s:Tlist_Log_Msg('Tlist_Window_Toggle()')
    " If taglist window is open then close it.
    let winnum = bufwinnr(g:TagList_title)
    if winnum != -1
        call s:Tlist_Window_Close()
        return
    endif

    call s:Tlist_Window_Open()

    " Go back to the original window, if Tlist_GainFocus_On_ToggleOpen is not
    " set
    if !g:Tlist_GainFocus_On_ToggleOpen
        call s:Tlist_Exe_Cmd_No_Acmds('wincmd p')
    endif

    " Update the taglist menu
    if g:Tlist_Show_Menu
        call s:Tlist_Menu_Update_File(0)
    endif
endfunction

" Tlist_Process_Filelist
" Process multiple files. Each filename is separated by "\n"
" Returns the number of processed files
function! s:Tlist_Process_Filelist(file_names)
    let flist = a:file_names

    " Enable lazy screen updates
    let old_lazyredraw = &lazyredraw
    set lazyredraw

    " Keep track of the number of processed files
    let fcnt = 0

    " Process one file at a time
    while flist != ''
        let nl_idx = stridx(flist, "\n")
        let one_file = strpart(flist, 0, nl_idx)

        " Remove the filename from the list
        let flist = strpart(flist, nl_idx + 1)

        if one_file == ''
            continue
        endif

        " Skip directories
        if isdirectory(one_file)
            continue
        endif

        let ftype = s:Tlist_Detect_Filetype(one_file)

        echon "\r                                                              "
        echon "\rProcessing tags for " . fnamemodify(one_file, ':p:t')

        let fcnt = fcnt + 1

        call Tlist_Update_File(one_file, ftype)
    endwhile

    " Clear the displayed informational messages
    echon "\r                                                            "

    " Restore the previous state
    let &lazyredraw = old_lazyredraw

    return fcnt
endfunction

" Tlist_Process_Dir
" Process the files in a directory matching the specified pattern
function! s:Tlist_Process_Dir(dir_name, pat)
    let flist = glob(a:dir_name . '/' . a:pat) . "\n"

    let fcnt = s:Tlist_Process_Filelist(flist)

    let len = strlen(a:dir_name)
    if a:dir_name[len - 1] == '\' || a:dir_name[len - 1] == '/'
        let glob_expr = a:dir_name . '*'
    else
        let glob_expr = a:dir_name . '/*'
    endif
    let all_files = glob(glob_expr) . "\n"

    while all_files != ''
        let nl_idx = stridx(all_files, "\n")
        let one_file = strpart(all_files, 0, nl_idx)

        let all_files = strpart(all_files, nl_idx + 1)
        if one_file == ''
            continue
        endif

        " Skip non-directory names
        if !isdirectory(one_file)
            continue
        endif

        echon "\r                                                              "
        echon "\rProcessing files in directory " . fnamemodify(one_file, ':t')
        let fcnt = fcnt + s:Tlist_Process_Dir(one_file, a:pat)
    endwhile

    return fcnt
endfunction

" Tlist_Add_Files_Recursive
" Add files recursively from a directory
function! s:Tlist_Add_Files_Recursive(dir, ...)
    let dir_name = fnamemodify(a:dir, ':p')
    if !isdirectory(dir_name)
        call s:Tlist_Warning_Msg('Error: ' . dir_name . ' is not a directory')
        return
    endif

    if a:0 == 1
        " User specified file pattern
        let pat = a:1
    else
        " Default file pattern
        let pat = '*'
    endif

    echon "\r                                                              "
    echon "\rProcessing files in directory " . fnamemodify(dir_name, ':t')
    let fcnt = s:Tlist_Process_Dir(dir_name, pat)

    echon "\rAdded " . fcnt . " files to the taglist"
endfunction

" Tlist_Add_Files
" Add the specified list of files to the taglist
function! s:Tlist_Add_Files(...)
    let flist = ''
    let i = 1

    " Get all the files matching the file patterns supplied as argument
    while i <= a:0
        let flist = flist . glob(a:{i}) . "\n"
        let i = i + 1
    endwhile

    if flist == ''
        call s:Tlist_Warning_Msg('Error: No matching files are found')
        return
    endif

    let fcnt = s:Tlist_Process_Filelist(flist)
    echon "\rAdded " . fcnt . " files to the taglist"
endfunction

" Tlist_Extract_Tagtype
" Extract the tag type from the tag text
function! s:Tlist_Extract_Tagtype(tag_line)
    " The tag type is after the tag prototype field. The prototype field
    " ends with the /;"\t string. We add 4 at the end to skip the characters
    " in this special string..
    let start = strridx(a:tag_line, '/;"' . "\t") + 4
    let end = strridx(a:tag_line, 'line:') - 1
    let ttype = strpart(a:tag_line, start, end - start)

    return ttype
endfunction

" Tlist_Extract_Tag_Scope
" Extract the tag scope from the tag text
function! s:Tlist_Extract_Tag_Scope(tag_line)
    let start = strridx(a:tag_line, 'line:')
    let end = strridx(a:tag_line, "\t")
    if end <= start
        return ''
    endif

    let tag_scope = strpart(a:tag_line, end + 1)
    let tag_scope = strpart(tag_scope, stridx(tag_scope, ':') + 1)

    return tag_scope
endfunction

" Tlist_Refresh()
" Refresh the taglist
function! s:Tlist_Refresh()
    call s:Tlist_Log_Msg('Tlist_Refresh (Skip_Refresh = ' .
                \ s:Tlist_Skip_Refresh . ', ' . bufname('%') . ')')
    " If we are entering the buffer from one of the taglist functions, then
    " no need to refresh the taglist window again.
    if s:Tlist_Skip_Refresh
        " We still need to update the taglist menu
        if g:Tlist_Show_Menu
            call s:Tlist_Menu_Update_File(0)
        endif
        return
    endif

    " If part of the winmanager plugin and not configured to process
    " tags always and not configured to display the tags menu, then return
    if (s:tlist_app_name == 'winmanager') && !g:Tlist_Process_File_Always
                \ && !g:Tlist_Show_Menu
        return
    endif

    " Skip buffers with 'buftype' set to nofile, nowrite, quickfix or help
    if &buftype != ''
        return
    endif

    let filename = fnamemodify(bufname('%'), ':p')
    let ftype = s:Tlist_Get_Buffer_Filetype('%')

    " If the file doesn't support tag listing, skip it
    if s:Tlist_Skip_File(filename, ftype)
        return
    endif

    let tlist_win = bufwinnr(g:TagList_title)

    " If the taglist window is not opened and not configured to process
    " tags always and not displaying the tags menu, then return
    if tlist_win == -1 && !g:Tlist_Process_File_Always && !g:Tlist_Show_Menu
        return
    endif

    let fidx = s:Tlist_Get_File_Index(filename)
    if fidx == -1
        " Check whether this file is removed based on user request
        " If it is, then don't display the tags for this file
        if s:Tlist_User_Removed_File(filename)
            return
        endif

        " If the taglist should not be auto updated, then return
        if !g:Tlist_Auto_Update
            return
        endif
    endif

    let cur_lnum = line('.')

    if fidx == -1
        " Update the tags for the file
        let fidx = s:Tlist_Process_File(filename, ftype)
    else
        let mtime = getftime(filename)
        if s:tlist_{fidx}_mtime != mtime
            " Invalidate the tags listed for this file
            let s:tlist_{fidx}_valid = 0

            " Update the taglist and the window
            call Tlist_Update_File(filename, ftype)

            " Store the new file modification time
            let s:tlist_{fidx}_mtime = mtime
        endif
    endif

    " Update the taglist window
    if tlist_win != -1
        " Disable screen updates
        let old_lazyredraw = &lazyredraw
        set nolazyredraw

        " Save the current window number
        let save_winnr = winnr()

        " Goto the taglist window
        call s:Tlist_Window_Goto_Window()

        if !g:Tlist_Auto_Highlight_Tag || !g:Tlist_Highlight_Tag_On_BufEnter
            " Save the cursor position
            let save_line = line('.')
            let save_col = col('.')
        endif

        " Update the taglist window
        call s:Tlist_Window_Refresh_File(filename, ftype)

        " Open the fold for the file
        exe "silent! " . s:tlist_{fidx}_start . "," .
                    \ s:tlist_{fidx}_end . "foldopen!"

        if g:Tlist_Highlight_Tag_On_BufEnter && g:Tlist_Auto_Highlight_Tag
            if g:Tlist_Show_One_File && s:tlist_cur_file_idx != fidx
                " If displaying tags for only one file in the taglist
                " window and about to display the tags for a new file,
                " then center the current tag line for the new file
                let center_tag_line = 1
            else
                let center_tag_line = 0
            endif

            " Highlight the current tag
            call s:Tlist_Window_Highlight_Tag(filename, cur_lnum, 1, center_tag_line)
        else
            " Restore the cursor position
            if v:version >= 601
                call cursor(save_line, save_col)
            else
                exe save_line
                exe 'normal! ' . save_col . '|'
            endif
        endif

        " Jump back to the original window
        if save_winnr != winnr()
            call s:Tlist_Exe_Cmd_No_Acmds(save_winnr . 'wincmd w')
        endif

        " Restore screen updates
        let &lazyredraw = old_lazyredraw
    endif

    " Update the taglist menu
    if g:Tlist_Show_Menu
        call s:Tlist_Menu_Update_File(0)
    endif
endfunction

" Tlist_Change_Sort()
" Change the sort order of the tag listing
" caller == 'cmd', command used in the taglist window
" caller == 'menu', taglist menu
" action == 'toggle', toggle sort from name to order and vice versa
" action == 'set', set the sort order to sort_type
function! s:Tlist_Change_Sort(caller, action, sort_type)
    call s:Tlist_Log_Msg('Tlist_Change_Sort (caller = ' . a:caller .
            \ ', action = ' . a:action . ', sort_type = ' . a:sort_type . ')')
    if a:caller == 'cmd'
        let fidx = s:Tlist_Window_Get_File_Index_By_Linenum(line('.'))
        if fidx == -1
            return
        endif

        " Remove the previous highlighting
        match none
    elseif a:caller == 'menu'
        let fidx = s:Tlist_Get_File_Index(fnamemodify(bufname('%'), ':p'))
        if fidx == -1
            return
        endif
    endif

    if a:action == 'toggle'
        let sort_type = s:tlist_{fidx}_sort_type

        " Toggle the sort order from 'name' to 'order' and vice versa
        if sort_type == 'name'
            let s:tlist_{fidx}_sort_type = 'order'
        else
            let s:tlist_{fidx}_sort_type = 'name'
        endif
    else
        let s:tlist_{fidx}_sort_type = a:sort_type
    endif

    " Invalidate the tags listed for this file
    let s:tlist_{fidx}_valid = 0

    if a:caller  == 'cmd'
        " Save the current line for later restoration
        let curline = '\V\^' . getline('.') . '\$'

        call s:Tlist_Window_Refresh_File(s:tlist_{fidx}_filename,
                    \   s:tlist_{fidx}_filetype)

        exe s:tlist_{fidx}_start . ',' . s:tlist_{fidx}_end . 'foldopen!'

        " Go back to the cursor line before the tag list is sorted
        call search(curline, 'w')

        call s:Tlist_Menu_Update_File(1)
    else
        call s:Tlist_Menu_Remove_File()

        call s:Tlist_Refresh()
    endif
endfunction

" Tlist_Update_Current_File()
" Update taglist for the current buffer by regenerating the tag list
" Contributed by WEN Guopeng.
function! s:Tlist_Update_Current_File()
    call s:Tlist_Log_Msg('Tlist_Update_Current_File()')
    if winnr() == bufwinnr(g:TagList_title)
        " In the taglist window. Update the current file
        call s:Tlist_Window_Update_File()
    else
        " Not in the taglist window. Update the current buffer
        let filename = fnamemodify(bufname('%'), ':p')
        let fidx = s:Tlist_Get_File_Index(filename)
        if fidx != -1
            let s:tlist_{fidx}_valid = 0
        endif
        let ft = s:Tlist_Get_Buffer_Filetype('%')
        call Tlist_Update_File(filename, ft)
    endif
endfunction

" Tlist_Window_Update_File()
" Update the tags displayed in the taglist window
function! s:Tlist_Window_Update_File()
    call s:Tlist_Log_Msg('Tlist_Window_Update_File()')
    let fidx = s:Tlist_Window_Get_File_Index_By_Linenum(line('.'))
    if fidx == -1
        return
    endif

    " Remove the previous highlighting
    match none

    " Save the current line for later restoration
    let curline = '\V\^' . getline('.') . '\$'

    let s:tlist_{fidx}_valid = 0

    " Update the taglist window
    call s:Tlist_Window_Refresh_File(s:tlist_{fidx}_filename,
                \ s:tlist_{fidx}_filetype)

    exe s:tlist_{fidx}_start . ',' . s:tlist_{fidx}_end . 'foldopen!'

    " Go back to the tag line before the list is updated
    call search(curline, 'w')
endfunction

" Tlist_Window_Get_Tag_Type_By_Linenum()
" Return the tag type index for the specified line in the taglist window
function! s:Tlist_Window_Get_Tag_Type_By_Linenum(fidx, lnum)
    let ftype = s:tlist_{a:fidx}_filetype

    " Determine to which tag type the current line number belongs to using the
    " tag type start line number and the number of tags in a tag type
    let i = 1
    while i <= s:tlist_{ftype}_count
        let ttype = s:tlist_{ftype}_{i}_name
        let start_lnum =
                    \ s:tlist_{a:fidx}_start + s:tlist_{a:fidx}_{ttype}_offset
        let end =  start_lnum + s:tlist_{a:fidx}_{ttype}_count
        if a:lnum >= start_lnum && a:lnum <= end
            break
        endif
        let i = i + 1
    endwhile

    " Current line doesn't belong to any of the displayed tag types
    if i > s:tlist_{ftype}_count
        return ''
    endif

    return ttype
endfunction

" Tlist_Window_Get_Tag_Index()
" Return the tag index for the specified line in the taglist window
function! s:Tlist_Window_Get_Tag_Index(fidx, lnum)
    let ttype = s:Tlist_Window_Get_Tag_Type_By_Linenum(a:fidx, a:lnum)

    " Current line doesn't belong to any of the displayed tag types
    if ttype == ''
        return 0
    endif

    " Compute the index into the displayed tags for the tag type
    let ttype_lnum = s:tlist_{a:fidx}_start + s:tlist_{a:fidx}_{ttype}_offset
    let tidx = a:lnum - ttype_lnum
    if tidx == 0
        return 0
    endif

    " Get the corresponding tag line and return it
    return s:tlist_{a:fidx}_{ttype}_{tidx}
endfunction

" Tlist_Window_Highlight_Line
" Highlight the current line
function! s:Tlist_Window_Highlight_Line()
    " Clear previously selected name
    match none

    " Highlight the current line
    if g:Tlist_Display_Prototype == 0
        let pat = '/\%' . line('.') . 'l\s\+\zs.*/'
    else
        let pat = '/\%' . line('.') . 'l.*/'
    endif

    exe 'match TagListTagName ' . pat
endfunction

" Tlist_Window_Open_File
" Open the specified file in either a new window or an existing window
" and place the cursor at the specified tag pattern
function! s:Tlist_Window_Open_File(win_ctrl, filename, tagpat)
    call s:Tlist_Log_Msg('Tlist_Window_Open_File (' . a:filename . ',' .
                \ a:win_ctrl . ')')
    let prev_Tlist_Skip_Refresh = s:Tlist_Skip_Refresh
    let s:Tlist_Skip_Refresh = 1

    if s:tlist_app_name == "winmanager"
        " Let the winmanager edit the file
        call WinManagerFileEdit(a:filename, a:win_ctrl == 'newwin')
    else

    if a:win_ctrl == 'newtab'
        " Create a new tab
        exe 'tabnew ' . escape(a:filename, ' ')
        " Open the taglist window in the new tab
        call s:Tlist_Window_Open()
    endif

    if a:win_ctrl == 'checktab'
        " Check whether the file is present in any of the tabs.
        " If the file is present in the current tab, then use the
        " current tab.
        if bufwinnr(a:filename) != -1
            let file_present_in_tab = 1
            let i = tabpagenr()
        else
            let i = 1
            let bnum = bufnr(a:filename)
            let file_present_in_tab = 0
            while i <= tabpagenr('$')
                if index(tabpagebuflist(i), bnum) != -1
                    let file_present_in_tab = 1
                    break
                endif
                let i += 1
            endwhile
        endif

        if file_present_in_tab
            " Goto the tab containing the file
            exe 'tabnext ' . i
        else
            " Open a new tab
            exe 'tabnew ' . escape(a:filename, ' ')

            " Open the taglist window
            call s:Tlist_Window_Open()
        endif
    endif

    let winnum = -1
    if a:win_ctrl == 'prevwin'
        " Open the file in the previous window, if it is usable
        let cur_win = winnr()
        wincmd p
        if &buftype == '' && !&previewwindow
            exe "edit " . escape(a:filename, ' ')
            let winnum = winnr()
        else
            " Previous window is not usable
            exe cur_win . 'wincmd w'
        endif
    endif

    " Goto the window containing the file.  If the window is not there, open a
    " new window
    if winnum == -1
        let winnum = bufwinnr(a:filename)
    endif

    if winnum == -1
        " Locate the previously used window for opening a file
        let fwin_num = 0
        let first_usable_win = 0

        let i = 1
        let bnum = winbufnr(i)
        while bnum != -1
            if getwinvar(i, 'tlist_file_window') == 'yes'
                let fwin_num = i
                break
            endif
            if first_usable_win == 0 &&
                        \ getbufvar(bnum, '&buftype') == '' &&
                        \ !getwinvar(i, '&previewwindow')
                " First non-taglist, non-plugin and non-preview window
                let first_usable_win = i
            endif
            let i = i + 1
            let bnum = winbufnr(i)
        endwhile

        " If a previously used window is not found, then use the first
        " non-taglist window
        if fwin_num == 0
            let fwin_num = first_usable_win
        endif

        if fwin_num != 0
            " Jump to the file window
            exe fwin_num . "wincmd w"

            " If the user asked to jump to the tag in a new window, then split
            " the existing window into two.
            if a:win_ctrl == 'newwin'
                split
            endif
            exe "edit " . escape(a:filename, ' ')
        else
            " Open a new window
            if g:Tlist_Use_Horiz_Window
                exe 'leftabove split ' . escape(a:filename, ' ')
            else
                if winbufnr(2) == -1
                    " Only the taglist window is present
                    if g:Tlist_Use_Right_Window
                        exe 'leftabove vertical split ' .
                                    \ escape(a:filename, ' ')
                    else
                        exe 'rightbelow vertical split ' .
                                    \ escape(a:filename, ' ')
                    endif

                    " Go to the taglist window to change the window size to
                    " the user configured value
                    call s:Tlist_Exe_Cmd_No_Acmds('wincmd p')
                    if g:Tlist_Use_Horiz_Window
                        exe 'resize ' . g:Tlist_WinHeight
                    else
                        exe 'vertical resize ' . g:Tlist_WinWidth
                    endif
                    " Go back to the file window
                    call s:Tlist_Exe_Cmd_No_Acmds('wincmd p')
                else
                    " A plugin or help window is also present
                    wincmd w
                    exe 'leftabove split ' . escape(a:filename, ' ')
                endif
            endif
        endif
        " Mark the window, so that it can be reused.
        call s:Tlist_Window_Mark_File_Window()
    else
        if v:version >= 700
            " If the file is opened in more than one window, then check
            " whether the last accessed window has the selected file.
            " If it does, then use that window.
            let lastwin_bufnum = winbufnr(winnr('#'))
            if bufnr(a:filename) == lastwin_bufnum
                let winnum = winnr('#')
            endif
        endif
        exe winnum . 'wincmd w'

        " If the user asked to jump to the tag in a new window, then split the
        " existing window into two.
        if a:win_ctrl == 'newwin'
            split
        endif
    endif
    endif

    " Jump to the tag
    if a:tagpat != ''
        " Add the current cursor position to the jump list, so that user can
        " jump back using the ' and ` marks.
        mark '
        silent call search(a:tagpat, 'w')

        " Bring the line to the middle of the window
        normal! z.

        " If the line is inside a fold, open the fold
        if foldclosed('.') != -1
            .foldopen
        endif
    endif

    " If the user selects to preview the tag then jump back to the
    " taglist window
    if a:win_ctrl == 'preview'
        " Go back to the taglist window
        let winnum = bufwinnr(g:TagList_title)
        exe winnum . 'wincmd w'
    else
        " If the user has selected to close the taglist window, when a
        " tag is selected, close the taglist  window
        if g:Tlist_Close_On_Select
            call s:Tlist_Window_Goto_Window()
            close

            " Go back to the window displaying the selected file
            let wnum = bufwinnr(a:filename)
            if wnum != -1 && wnum != winnr()
                call s:Tlist_Exe_Cmd_No_Acmds(wnum . 'wincmd w')
            endif
        endif
    endif

    let s:Tlist_Skip_Refresh = prev_Tlist_Skip_Refresh
endfunction

" Tlist_Window_Jump_To_Tag()
" Jump to the location of the current tag
" win_ctrl == useopen - Reuse the existing file window
" win_ctrl == newwin - Open a new window
" win_ctrl == preview - Preview the tag
" win_ctrl == prevwin - Open in previous window
" win_ctrl == newtab - Open in new tab
function! s:Tlist_Window_Jump_To_Tag(win_ctrl)
    call s:Tlist_Log_Msg('Tlist_Window_Jump_To_Tag(' . a:win_ctrl . ')')
    " Do not process comment lines and empty lines
    let curline = getline('.')
    if curline =~ '^\s*$' || curline[0] == '"'
        return
    endif

    " If inside a closed fold, then use the first line of the fold
    " and jump to the file.
    let lnum = foldclosed('.')
    if lnum == -1
        " Jump to the selected tag or file
        let lnum = line('.')
    else
        " Open the closed fold
        .foldopen!
    endif

    let fidx = s:Tlist_Window_Get_File_Index_By_Linenum(lnum)
    if fidx == -1
        return
    endif

    " Get the tag output for the current tag
    let tidx = s:Tlist_Window_Get_Tag_Index(fidx, lnum)
    if tidx != 0
        let tagpat = s:Tlist_Get_Tag_SearchPat(fidx, tidx)

        " Highlight the tagline
        call s:Tlist_Window_Highlight_Line()
    else
        " Selected a line which is not a tag name. Just edit the file
        let tagpat = ''
    endif

    call s:Tlist_Window_Open_File(a:win_ctrl, s:tlist_{fidx}_filename, tagpat)
endfunction

" Tlist_Window_Show_Info()
" Display information about the entry under the cursor
function! s:Tlist_Window_Show_Info()
    call s:Tlist_Log_Msg('Tlist_Window_Show_Info()')

    " Clear the previously displayed line
    echo

    " Do not process comment lines and empty lines
    let curline = getline('.')
    if curline =~ '^\s*$' || curline[0] == '"'
        return
    endif

    " If inside a fold, then don't display the prototype
    if foldclosed('.') != -1
        return
    endif

    let lnum = line('.')

    " Get the file index
    let fidx = s:Tlist_Window_Get_File_Index_By_Linenum(lnum)
    if fidx == -1
        return
    endif

    if lnum == s:tlist_{fidx}_start
        " Cursor is on a file name
        let fname = s:tlist_{fidx}_filename
        if strlen(fname) > 50
            let fname = fnamemodify(fname, ':t')
        endif
        echo fname . ', Filetype=' . s:tlist_{fidx}_filetype .
                    \  ', Tag count=' . s:tlist_{fidx}_tag_count
        return
    endif

    " Get the tag output line for the current tag
    let tidx = s:Tlist_Window_Get_Tag_Index(fidx, lnum)
    if tidx == 0
        " Cursor is on a tag type
        let ttype = s:Tlist_Window_Get_Tag_Type_By_Linenum(fidx, lnum)
        if ttype == ''
            return
        endif

        let ttype_name = ''

        let ftype = s:tlist_{fidx}_filetype
        let i = 1
        while i <= s:tlist_{ftype}_count
            if ttype == s:tlist_{ftype}_{i}_name
                let ttype_name = s:tlist_{ftype}_{i}_fullname
                break
            endif
            let i = i + 1
        endwhile

        echo 'Tag type=' . ttype_name .
                    \ ', Tag count=' . s:tlist_{fidx}_{ttype}_count
        return
    endif

    " Get the tag search pattern and display it
    echo s:Tlist_Get_Tag_Prototype(fidx, tidx)
endfunction

" Tlist_Find_Nearest_Tag_Idx
" Find the tag idx nearest to the supplied line number
" Returns -1, if a tag couldn't be found for the specified line number
function! s:Tlist_Find_Nearest_Tag_Idx(fidx, linenum)
    let sort_type = s:tlist_{a:fidx}_sort_type

    let left = 1
    let right = s:tlist_{a:fidx}_tag_count

    if sort_type == 'order'
        " Tags sorted by order, use a binary search.
        " The idea behind this function is taken from the ctags.vim script (by
        " Alexey Marinichev) available at the Vim online website.

        " If the current line is the less than the first tag, then no need to
        " search
        let first_lnum = s:Tlist_Get_Tag_Linenum(a:fidx, 1)

        if a:linenum < first_lnum
            return -1
        endif

        while left < right
            let middle = (right + left + 1) / 2
            let middle_lnum = s:Tlist_Get_Tag_Linenum(a:fidx, middle)

            if middle_lnum == a:linenum
                let left = middle
                break
            endif

            if middle_lnum > a:linenum
                let right = middle - 1
            else
                let left = middle
            endif
        endwhile
    else
        " Tags sorted by name, use a linear search. (contributed by Dave
        " Eggum).
        " Look for a tag with a line number less than or equal to the supplied
        " line number. If multiple tags are found, then use the tag with the
        " line number closest to the supplied line number. IOW, use the tag
        " with the highest line number.
        let closest_lnum = 0
        let final_left = 0
        while left <= right
            let lnum = s:Tlist_Get_Tag_Linenum(a:fidx, left)

            if lnum < a:linenum && lnum > closest_lnum
                let closest_lnum = lnum
                let final_left = left
            elseif lnum == a:linenum
                let closest_lnum = lnum
                let final_left = left
                break
            else
                let left = left + 1
            endif
        endwhile
        if closest_lnum == 0
            return -1
        endif
        if left >= right
            let left = final_left
        endif
    endif

    return left
endfunction

" Tlist_Window_Highlight_Tag()
" Highlight the current tag
" cntx == 1, Called by the taglist plugin itself
" cntx == 2, Forced by the user through the TlistHighlightTag command
" center = 1, move the tag line to the center of the taglist window
function! s:Tlist_Window_Highlight_Tag(filename, cur_lnum, cntx, center)
    " Highlight the current tag only if the user configured the
    " taglist plugin to do so or if the user explictly invoked the
    " command to highlight the current tag.
    if !g:Tlist_Auto_Highlight_Tag && a:cntx == 1
        return
    endif

    if a:filename == ''
        return
    endif

    " Make sure the taglist window is present
    let winnum = bufwinnr(g:TagList_title)
    if winnum == -1
        call s:Tlist_Warning_Msg('Error: Taglist window is not open')
        return
    endif

    let fidx = s:Tlist_Get_File_Index(a:filename)
    if fidx == -1
        return
    endif

    " If the file is currently not displayed in the taglist window, then retrn
    if !s:tlist_{fidx}_visible
        return
    endif

    " If there are no tags for this file, then no need to proceed further
    if s:tlist_{fidx}_tag_count == 0
        return
    endif

    " Ignore all autocommands
    let old_ei = &eventignore
    set eventignore=all

    " Save the original window number
    let org_winnr = winnr()

    if org_winnr == winnum
        let in_taglist_window = 1
    else
        let in_taglist_window = 0
    endif

    " Go to the taglist window
    if !in_taglist_window
        exe winnum . 'wincmd w'
    endif

    " Clear previously selected name
    match none

    let tidx = s:Tlist_Find_Nearest_Tag_Idx(fidx, a:cur_lnum)
    if tidx == -1
        " Make sure the current tag line is visible in the taglist window.
        " Calling the winline() function makes the line visible.  Don't know
        " of a better way to achieve this.
        let lnum = line('.')

        if lnum < s:tlist_{fidx}_start || lnum > s:tlist_{fidx}_end
            " Move the cursor to the beginning of the file
            exe s:tlist_{fidx}_start
        endif

        if foldclosed('.') != -1
            .foldopen
        endif

        call winline()

        if !in_taglist_window
            exe org_winnr . 'wincmd w'
        endif

        " Restore the autocommands
        let &eventignore = old_ei
        return
    endif

    " Extract the tag type
    let ttype = s:Tlist_Get_Tag_Type_By_Tag(fidx, tidx)

    " Compute the line number
    " Start of file + Start of tag type + offset
    let lnum = s:tlist_{fidx}_start + s:tlist_{fidx}_{ttype}_offset +
                \ s:tlist_{fidx}_{tidx}_ttype_idx

    " Goto the line containing the tag
    exe lnum

    " Open the fold
    if foldclosed('.') != -1
        .foldopen
    endif

    if a:center
        " Move the tag line to the center of the taglist window
        normal! z.
    else
        " Make sure the current tag line is visible in the taglist window.
        " Calling the winline() function makes the line visible.  Don't know
        " of a better way to achieve this.
        call winline()
    endif

    " Highlight the tag name
    call s:Tlist_Window_Highlight_Line()

    " Go back to the original window
    if !in_taglist_window
        exe org_winnr . 'wincmd w'
    endif

    " Restore the autocommands
    let &eventignore = old_ei
    return
endfunction

" Tlist_Get_Tag_Prototype_By_Line
" Get the prototype for the tag on or before the specified line number in the
" current buffer
function! Tlist_Get_Tag_Prototype_By_Line(...)
    if a:0 == 0
        " Arguments are not supplied. Use the current buffer name
        " and line number
        let filename = bufname('%')
        let linenr = line('.')
    elseif a:0 == 2
        " Filename and line number are specified
        let filename = a:1
        let linenr = a:2
        if linenr !~ '\d\+'
            " Invalid line number
            return ""
        endif
    else
        " Sufficient arguments are not supplied
        let msg =  'Usage: Tlist_Get_Tag_Prototype_By_Line <filename> ' .
                                \ '<line_number>'
        call s:Tlist_Warning_Msg(msg)
        return ""
    endif

    " Expand the file to a fully qualified name
    let filename = fnamemodify(filename, ':p')
    if filename == ''
        return ""
    endif

    let fidx = s:Tlist_Get_File_Index(filename)
    if fidx == -1
        return ""
    endif

    " If there are no tags for this file, then no need to proceed further
    if s:tlist_{fidx}_tag_count == 0
        return ""
    endif

    " Get the tag text using the line number
    let tidx = s:Tlist_Find_Nearest_Tag_Idx(fidx, linenr)
    if tidx == -1
        return ""
    endif

    return s:Tlist_Get_Tag_Prototype(fidx, tidx)
endfunction

" Tlist_Get_Tagname_By_Line
" Get the tag name on or before the specified line number in the
" current buffer
function! Tlist_Get_Tagname_By_Line(...)
    if a:0 == 0
        " Arguments are not supplied. Use the current buffer name
        " and line number
        let filename = bufname('%')
        let linenr = line('.')
    elseif a:0 == 2
        " Filename and line number are specified
        let filename = a:1
        let linenr = a:2
        if linenr !~ '\d\+'
            " Invalid line number
            return ""
        endif
    else
        " Sufficient arguments are not supplied
        let msg =  'Usage: Tlist_Get_Tagname_By_Line <filename> <line_number>'
        call s:Tlist_Warning_Msg(msg)
        return ""
    endif

    " Make sure the current file has a name
    let filename = fnamemodify(filename, ':p')
    if filename == ''
        return ""
    endif

    let fidx = s:Tlist_Get_File_Index(filename)
    if fidx == -1
        return ""
    endif

    " If there are no tags for this file, then no need to proceed further
    if s:tlist_{fidx}_tag_count == 0
        return ""
    endif

    " Get the tag name using the line number
    let tidx = s:Tlist_Find_Nearest_Tag_Idx(fidx, linenr)
    if tidx == -1
        return ""
    endif

    return s:tlist_{fidx}_{tidx}_tag_name
endfunction

" Tlist_Window_Move_To_File
" Move the cursor to the beginning of the current file or the next file
" or the previous file in the taglist window
" dir == -1, move to start of current or previous function
" dir == 1, move to start of next function
function! s:Tlist_Window_Move_To_File(dir)
    if foldlevel('.') == 0
        " Cursor is on a non-folded line (it is not in any of the files)
        " Move it to a folded line
        if a:dir == -1
            normal! zk
        else
            " While moving down to the start of the next fold,
            " no need to do go to the start of the next file.
            normal! zj
            return
        endif
    endif

    let fidx = s:Tlist_Window_Get_File_Index_By_Linenum(line('.'))
    if fidx == -1
        return
    endif

    let cur_lnum = line('.')

    if a:dir == -1
        if cur_lnum > s:tlist_{fidx}_start
            " Move to the beginning of the current file
            exe s:tlist_{fidx}_start
            return
        endif

        if fidx != 0
            " Move to the beginning of the previous file
            let fidx = fidx - 1
        else
            " Cursor is at the first file, wrap around to the last file
            let fidx = s:tlist_file_count - 1
        endif

        exe s:tlist_{fidx}_start
        return
    else
        " Move to the beginning of the next file
        let fidx = fidx + 1

        if fidx >= s:tlist_file_count
            " Cursor is at the last file, wrap around to the first file
            let fidx = 0
        endif

        if s:tlist_{fidx}_start != 0
            exe s:tlist_{fidx}_start
        endif
        return
    endif
endfunction

" Tlist_Session_Load
" Load a taglist session (information about all the displayed files
" and the tags) from the specified file
function! s:Tlist_Session_Load(...)
    if a:0 == 0 || a:1 == ''
        call s:Tlist_Warning_Msg('Usage: TlistSessionLoad <filename>')
        return
    endif

    let sessionfile = a:1

    if !filereadable(sessionfile)
        let msg = 'Taglist: Error - Unable to open file ' . sessionfile
        call s:Tlist_Warning_Msg(msg)
        return
    endif

    " Mark the current window as the file window
    call s:Tlist_Window_Mark_File_Window()

    " Source the session file
    exe 'source ' . sessionfile

    let new_file_count = g:tlist_file_count
    unlet! g:tlist_file_count

    let i = 0
    while i < new_file_count
        let ftype = g:tlist_{i}_filetype
        unlet! g:tlist_{i}_filetype

        if !exists('s:tlist_' . ftype . '_count')
            if s:Tlist_FileType_Init(ftype) == 0
                let i = i + 1
                continue
            endif
        endif

        let fname = g:tlist_{i}_filename
        unlet! g:tlist_{i}_filename

        let fidx = s:Tlist_Get_File_Index(fname)
        if fidx != -1
            let s:tlist_{fidx}_visible = 0
            let i = i + 1
            continue
        else
            " As we are loading the tags from the session file, if this
            " file was previously deleted by the user, now we need to
            " add it back. So remove the file from the deleted list.
            call s:Tlist_Update_Remove_List(fname, 0)
        endif

        let fidx = s:Tlist_Init_File(fname, ftype)

        let s:tlist_{fidx}_filename = fname

        let s:tlist_{fidx}_sort_type = g:tlist_{i}_sort_type
        unlet! g:tlist_{i}_sort_type

        let s:tlist_{fidx}_filetype = ftype
        let s:tlist_{fidx}_mtime = getftime(fname)

        let s:tlist_{fidx}_start = 0
        let s:tlist_{fidx}_end = 0

        let s:tlist_{fidx}_valid = 1

        let s:tlist_{fidx}_tag_count = g:tlist_{i}_tag_count
        unlet! g:tlist_{i}_tag_count

        let j = 1
        while j <= s:tlist_{fidx}_tag_count
            let s:tlist_{fidx}_{j}_tag = g:tlist_{i}_{j}_tag
            let s:tlist_{fidx}_{j}_tag_name = g:tlist_{i}_{j}_tag_name
            let s:tlist_{fidx}_{j}_ttype_idx = g:tlist_{i}_{j}_ttype_idx
            unlet! g:tlist_{i}_{j}_tag
            unlet! g:tlist_{i}_{j}_tag_name
            unlet! g:tlist_{i}_{j}_ttype_idx
            let j = j + 1
        endwhile

        let j = 1
        while j <= s:tlist_{ftype}_count
            let ttype = s:tlist_{ftype}_{j}_name

            if exists('g:tlist_' . i . '_' . ttype)
                let s:tlist_{fidx}_{ttype} = g:tlist_{i}_{ttype}
                unlet! g:tlist_{i}_{ttype}
                let s:tlist_{fidx}_{ttype}_offset = 0
                let s:tlist_{fidx}_{ttype}_count = g:tlist_{i}_{ttype}_count
                unlet! g:tlist_{i}_{ttype}_count

                let k = 1
                while k <= s:tlist_{fidx}_{ttype}_count
                    let s:tlist_{fidx}_{ttype}_{k} = g:tlist_{i}_{ttype}_{k}
                    unlet! g:tlist_{i}_{ttype}_{k}
                    let k = k + 1
                endwhile
            else
                let s:tlist_{fidx}_{ttype} = ''
                let s:tlist_{fidx}_{ttype}_offset = 0
                let s:tlist_{fidx}_{ttype}_count = 0
            endif

            let j = j + 1
        endwhile

        let i = i + 1
    endwhile

    " If the taglist window is open, then update it
    let winnum = bufwinnr(g:TagList_title)
    if winnum != -1
        let save_winnr = winnr()

        " Goto the taglist window
        call s:Tlist_Window_Goto_Window()

        " Refresh the taglist window
        call s:Tlist_Window_Refresh()

        " Go back to the original window
        if save_winnr != winnr()
            call s:Tlist_Exe_Cmd_No_Acmds('wincmd p')
        endif
    endif
endfunction

" Tlist_Session_Save
" Save a taglist session (information about all the displayed files
" and the tags) into the specified file
function! s:Tlist_Session_Save(...)
    if a:0 == 0 || a:1 == ''
        call s:Tlist_Warning_Msg('Usage: TlistSessionSave <filename>')
        return
    endif

    let sessionfile = a:1

    if s:tlist_file_count == 0
        " There is nothing to save
        call s:Tlist_Warning_Msg('Warning: Taglist is empty. Nothing to save.')
        return
    endif

    if filereadable(sessionfile)
        let ans = input('Do you want to overwrite ' . sessionfile . ' (Y/N)?')
        if ans !=? 'y'
            return
        endif

        echo "\n"
    endif

    let old_verbose = &verbose
    set verbose&vim

    exe 'redir! > ' . sessionfile

    silent! echo '" Taglist session file. This file is auto-generated.'
    silent! echo '" File information'
    silent! echo 'let tlist_file_count = ' . s:tlist_file_count

    let i = 0

    while i < s:tlist_file_count
        " Store information about the file
        silent! echo 'let tlist_' . i . "_filename = '" .
                                            \ s:tlist_{i}_filename . "'"
        silent! echo 'let tlist_' . i . '_sort_type = "' .
                                                \ s:tlist_{i}_sort_type . '"'
        silent! echo 'let tlist_' . i . '_filetype = "' .
                                            \ s:tlist_{i}_filetype . '"'
        silent! echo 'let tlist_' . i . '_tag_count = ' .
                                                        \ s:tlist_{i}_tag_count
        " Store information about all the tags
        let j = 1
        while j <= s:tlist_{i}_tag_count
            let txt = escape(s:tlist_{i}_{j}_tag, '"\\')
            silent! echo 'let tlist_' . i . '_' . j . '_tag = "' . txt . '"'
            silent! echo 'let tlist_' . i . '_' . j . '_tag_name = "' .
                        \ s:tlist_{i}_{j}_tag_name . '"'
            silent! echo 'let tlist_' . i . '_' . j . '_ttype_idx' . ' = ' .
                        \ s:tlist_{i}_{j}_ttype_idx
            let j = j + 1
        endwhile

        " Store information about all the tags grouped by their type
        let ftype = s:tlist_{i}_filetype
        let j = 1
        while j <= s:tlist_{ftype}_count
            let ttype = s:tlist_{ftype}_{j}_name
            if s:tlist_{i}_{ttype}_count != 0
                let txt = escape(s:tlist_{i}_{ttype}, '"\')
                let txt = substitute(txt, "\n", "\\\\n", 'g')
                silent! echo 'let tlist_' . i . '_' . ttype . ' = "' .
                                                \ txt . '"'
                silent! echo 'let tlist_' . i . '_' . ttype . '_count = ' .
                                                     \ s:tlist_{i}_{ttype}_count
                let k = 1
                while k <= s:tlist_{i}_{ttype}_count
                    silent! echo 'let tlist_' . i . '_' . ttype . '_' . k .
                                \ ' = ' . s:tlist_{i}_{ttype}_{k}
                    let k = k + 1
                endwhile
            endif
            let j = j + 1
        endwhile

        silent! echo

        let i = i + 1
    endwhile

    redir END

    let &verbose = old_verbose
endfunction

" Tlist_Buffer_Removed
" A buffer is removed from the Vim buffer list. Remove the tags defined
" for that file
function! s:Tlist_Buffer_Removed(filename)
    call s:Tlist_Log_Msg('Tlist_Buffer_Removed (' . a:filename .  ')')

    " Make sure a valid filename is supplied
    if a:filename == ''
        return
    endif

    " Get tag list index of the specified file
    let fidx = s:Tlist_Get_File_Index(a:filename)
    if fidx == -1
        " File not present in the taglist
        return
    endif

    " Remove the file from the list
    call s:Tlist_Remove_File(fidx, 0)
endfunction

" When a buffer is deleted, remove the file from the taglist
autocmd BufDelete * silent call s:Tlist_Buffer_Removed(expand('<afile>:p'))

" Tlist_Window_Open_File_Fold
" Open the fold for the specified file and close the fold for all the
" other files
function! s:Tlist_Window_Open_File_Fold(acmd_bufnr)
    call s:Tlist_Log_Msg('Tlist_Window_Open_File_Fold (' . a:acmd_bufnr . ')')

    " Make sure the taglist window is present
    let winnum = bufwinnr(g:TagList_title)
    if winnum == -1
        call s:Tlist_Warning_Msg('Taglist: Error - Taglist window is not open')
        return
    endif

    " Save the original window number
    let org_winnr = winnr()
    if org_winnr == winnum
        let in_taglist_window = 1
    else
        let in_taglist_window = 0
    endif

    if in_taglist_window
        " When entering the taglist window, no need to update the folds
        return
    endif

    " Go to the taglist window
    if !in_taglist_window
        call s:Tlist_Exe_Cmd_No_Acmds(winnum . 'wincmd w')
    endif

    " Close all the folds
    silent! %foldclose

    " Get tag list index of the specified file
    let fname = fnamemodify(bufname(a:acmd_bufnr + 0), ':p')
    if filereadable(fname)
        let fidx = s:Tlist_Get_File_Index(fname)
        if fidx != -1
            " Open the fold for the file
            exe "silent! " . s:tlist_{fidx}_start . "," .
                        \ s:tlist_{fidx}_end . "foldopen"
        endif
    endif

    " Go back to the original window
    if !in_taglist_window
        call s:Tlist_Exe_Cmd_No_Acmds(org_winnr . 'wincmd w')
    endif
endfunction

" Tlist_Window_Check_Auto_Open
" Open the taglist window automatically on Vim startup.
" Open the window only when files present in any of the Vim windows support
" tags.
function! s:Tlist_Window_Check_Auto_Open()
    let open_window = 0

    let i = 1
    let buf_num = winbufnr(i)
    while buf_num != -1
        let filename = fnamemodify(bufname(buf_num), ':p')
        let ft = s:Tlist_Get_Buffer_Filetype(buf_num)
        if !s:Tlist_Skip_File(filename, ft)
            let open_window = 1
            break
        endif
        let i = i + 1
        let buf_num = winbufnr(i)
    endwhile

    if open_window
        call s:Tlist_Window_Toggle()
    endif
endfunction

" Tlist_Refresh_Folds
" Remove and create the folds for all the files displayed in the taglist
" window. Used after entering a tab. If this is not done, then the folds
" are not properly created for taglist windows displayed in multiple tabs.
function! s:Tlist_Refresh_Folds()
    let winnum = bufwinnr(g:TagList_title)
    if winnum == -1
        return
    endif

    let save_wnum = winnr()
    exe winnum . 'wincmd w'

    " First remove all the existing folds
    normal! zE

    " Create the folds for each in the tag list
    let fidx = 0
    while fidx < s:tlist_file_count
        let ftype = s:tlist_{fidx}_filetype

        " Create the folds for each tag type in a file
        let j = 1
        while j <= s:tlist_{ftype}_count
            let ttype = s:tlist_{ftype}_{j}_name
            if s:tlist_{fidx}_{ttype}_count
                let s = s:tlist_{fidx}_start + s:tlist_{fidx}_{ttype}_offset
                let e = s + s:tlist_{fidx}_{ttype}_count
                exe s . ',' . e . 'fold'
            endif
            let j = j + 1
        endwhile

        exe s:tlist_{fidx}_start . ',' . s:tlist_{fidx}_end . 'fold'
        exe 'silent! ' . s:tlist_{fidx}_start . ',' .
                    \ s:tlist_{fidx}_end . 'foldopen!'
        let fidx = fidx + 1
    endwhile

    exe save_wnum . 'wincmd w'
endfunction

function! s:Tlist_Menu_Add_Base_Menu()
    call s:Tlist_Log_Msg('Adding the base menu')

    " Add the menu
    anoremenu <silent> T&ags.Refresh\ menu :call <SID>Tlist_Menu_Refresh()<CR>
    anoremenu <silent> T&ags.Sort\ menu\ by.Name
                    \ :call <SID>Tlist_Change_Sort('menu', 'set', 'name')<CR>
    anoremenu <silent> T&ags.Sort\ menu\ by.Order
                    \ :call <SID>Tlist_Change_Sort('menu', 'set', 'order')<CR>
    anoremenu T&ags.-SEP1-           :

    if &mousemodel =~ 'popup'
        anoremenu <silent> PopUp.T&ags.Refresh\ menu
                    \ :call <SID>Tlist_Menu_Refresh()<CR>
        anoremenu <silent> PopUp.T&ags.Sort\ menu\ by.Name
                  \ :call <SID>Tlist_Change_Sort('menu', 'set', 'name')<CR>
        anoremenu <silent> PopUp.T&ags.Sort\ menu\ by.Order
                  \ :call <SID>Tlist_Change_Sort('menu', 'set', 'order')<CR>
        anoremenu PopUp.T&ags.-SEP1-           :
    endif
endfunction

let s:menu_char_prefix =
            \ '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

" Tlist_Menu_Get_Tag_Type_Cmd
" Get the menu command for the specified tag type
" fidx - File type index
" ftype - File Type
" add_ttype_name - To add or not to add the tag type name to the menu entries
" ttype_idx - Tag type index
function! s:Tlist_Menu_Get_Tag_Type_Cmd(fidx, ftype, add_ttype_name, ttype_idx)
    " Curly brace variable name optimization
    let ftype_ttype_idx = a:ftype . '_' . a:ttype_idx

    let ttype = s:tlist_{ftype_ttype_idx}_name
    if a:add_ttype_name
        " If the tag type name contains space characters, escape it. This
        " will be used to create the menu entries.
        let ttype_fullname = escape(s:tlist_{ftype_ttype_idx}_fullname, ' ')
    endif

    " Curly brace variable name optimization
    let fidx_ttype = a:fidx . '_' . ttype

    " Number of tag entries for this tag type
    let tcnt = s:tlist_{fidx_ttype}_count
    if tcnt == 0 " No entries for this tag type
        return ''
    endif

    let mcmd = ''

    " Create the menu items for the tags.
    " Depending on the number of tags of this type, split the menu into
    " multiple sub-menus, if needed.
    if tcnt > g:Tlist_Max_Submenu_Items
        let j = 1
        while j <= tcnt
            let final_index = j + g:Tlist_Max_Submenu_Items - 1
            if final_index > tcnt
                let final_index = tcnt
            endif

            " Extract the first and last tag name and form the
            " sub-menu name
            let tidx = s:tlist_{fidx_ttype}_{j}
            let first_tag = s:tlist_{a:fidx}_{tidx}_tag_name

            let tidx = s:tlist_{fidx_ttype}_{final_index}
            let last_tag = s:tlist_{a:fidx}_{tidx}_tag_name

            " Truncate the names, if they are greater than the
            " max length
            let first_tag = strpart(first_tag, 0, g:Tlist_Max_Tag_Length)
            let last_tag = strpart(last_tag, 0, g:Tlist_Max_Tag_Length)

            " Form the menu command prefix
            let m_prefix = 'anoremenu <silent> T\&ags.'
            if a:add_ttype_name
                let m_prefix = m_prefix . ttype_fullname . '.'
            endif
            let m_prefix = m_prefix . first_tag . '\.\.\.' . last_tag . '.'

            " Character prefix used to number the menu items (hotkey)
            let m_prefix_idx = 0

            while j <= final_index
                let tidx = s:tlist_{fidx_ttype}_{j}

                let tname = s:tlist_{a:fidx}_{tidx}_tag_name

                let mcmd = mcmd . m_prefix . '\&' .
                            \ s:menu_char_prefix[m_prefix_idx] . '\.' .
                            \ tname . ' :call <SID>Tlist_Menu_Jump_To_Tag(' .
                            \ tidx . ')<CR>|'

                let m_prefix_idx = m_prefix_idx + 1
                let j = j + 1
            endwhile
        endwhile
    else
        " Character prefix used to number the menu items (hotkey)
        let m_prefix_idx = 0

        let m_prefix = 'anoremenu <silent> T\&ags.'
        if a:add_ttype_name
            let m_prefix = m_prefix . ttype_fullname . '.'
        endif
        let j = 1
        while j <= tcnt
            let tidx = s:tlist_{fidx_ttype}_{j}

            let tname = s:tlist_{a:fidx}_{tidx}_tag_name

            let mcmd = mcmd . m_prefix . '\&' .
                        \ s:menu_char_prefix[m_prefix_idx] . '\.' .
                        \ tname . ' :call <SID>Tlist_Menu_Jump_To_Tag(' . tidx
                        \ . ')<CR>|'

            let m_prefix_idx = m_prefix_idx + 1
            let j = j + 1
        endwhile
    endif

    return mcmd
endfunction

" Update the taglist menu with the tags for the specified file
function! s:Tlist_Menu_File_Refresh(fidx)
    call s:Tlist_Log_Msg('Refreshing the tag menu for ' . s:tlist_{a:fidx}_filename)
    " The 'B' flag is needed in the 'cpoptions' option
    let old_cpoptions = &cpoptions
    set cpoptions&vim

    exe s:tlist_{a:fidx}_menu_cmd

    " Update the popup menu (if enabled)
    if &mousemodel =~ 'popup'
        let cmd = substitute(s:tlist_{a:fidx}_menu_cmd, ' T\\&ags\.',
                                        \ ' PopUp.T\\\&ags.', "g")
        exe cmd
    endif

    " The taglist menu is not empty now
    let s:tlist_menu_empty = 0

    " Restore the 'cpoptions' settings
    let &cpoptions = old_cpoptions
endfunction

" Tlist_Menu_Update_File
" Add the taglist menu
function! s:Tlist_Menu_Update_File(clear_menu)
    if !has('gui_running')
        " Not running in GUI mode
        return
    endif

    call s:Tlist_Log_Msg('Updating the tag menu, clear_menu = ' . a:clear_menu)

    " Remove the tags menu
    if a:clear_menu
        call s:Tlist_Menu_Remove_File()

    endif

    " Skip buffers with 'buftype' set to nofile, nowrite, quickfix or help
    if &buftype != ''
        return
    endif

    let filename = fnamemodify(bufname('%'), ':p')
    let ftype = s:Tlist_Get_Buffer_Filetype('%')

    " If the file doesn't support tag listing, skip it
    if s:Tlist_Skip_File(filename, ftype)
        return
    endif

    let fidx = s:Tlist_Get_File_Index(filename)
    if fidx == -1 || !s:tlist_{fidx}_valid
        " Check whether this file is removed based on user request
        " If it is, then don't display the tags for this file
        if s:Tlist_User_Removed_File(filename)
            return
        endif

        " Process the tags for the file
        let fidx = s:Tlist_Process_File(filename, ftype)
        if fidx == -1
            return
        endif
    endif

    let fname = escape(fnamemodify(bufname('%'), ':t'), '.')
    if fname != ''
        exe 'anoremenu T&ags.' .  fname . ' <Nop>'
        anoremenu T&ags.-SEP2-           :
    endif

    if !s:tlist_{fidx}_tag_count
        return
    endif

    if s:tlist_{fidx}_menu_cmd != ''
        " Update the menu with the cached command
        call s:Tlist_Menu_File_Refresh(fidx)

        return
    endif

    " We are going to add entries to the tags menu, so the menu won't be
    " empty
    let s:tlist_menu_empty = 0

    let cmd = ''

    " Determine whether the tag type name needs to be added to the menu
    " If more than one tag type is present in the taglisting for a file,
    " then the tag type name needs to be present
    let add_ttype_name = -1
    let i = 1
    while i <= s:tlist_{ftype}_count && add_ttype_name < 1
        let ttype = s:tlist_{ftype}_{i}_name
        if s:tlist_{fidx}_{ttype}_count
            let add_ttype_name = add_ttype_name + 1
        endif
        let i = i + 1
    endwhile

    " Process the tags by the tag type and get the menu command
    let i = 1
    while i <= s:tlist_{ftype}_count
        let mcmd = s:Tlist_Menu_Get_Tag_Type_Cmd(fidx, ftype, add_ttype_name, i)
        if mcmd != ''
            let cmd = cmd . mcmd
        endif

        let i = i + 1
    endwhile

    " Cache the menu command for reuse
    let s:tlist_{fidx}_menu_cmd = cmd

    " Update the menu
    call s:Tlist_Menu_File_Refresh(fidx)
endfunction

" Tlist_Menu_Remove_File
" Remove the tags displayed in the tags menu
function! s:Tlist_Menu_Remove_File()
    if !has('gui_running') || s:tlist_menu_empty
        return
    endif

    call s:Tlist_Log_Msg('Removing the tags menu for a file')

    " Cleanup the Tags menu
    silent! unmenu T&ags
    if &mousemodel =~ 'popup'
        silent! unmenu PopUp.T&ags
    endif

    " Add a dummy menu item to retain teared off menu
    noremenu T&ags.Dummy l

    silent! unmenu! T&ags
    if &mousemodel =~ 'popup'
        silent! unmenu! PopUp.T&ags
    endif

    call s:Tlist_Menu_Add_Base_Menu()

    " Remove the dummy menu item
    unmenu T&ags.Dummy

    let s:tlist_menu_empty = 1
endfunction

" Tlist_Menu_Refresh
" Refresh the taglist menu
function! s:Tlist_Menu_Refresh()
    call s:Tlist_Log_Msg('Refreshing the tags menu')
    let fidx = s:Tlist_Get_File_Index(fnamemodify(bufname('%'), ':p'))
    if fidx != -1
        " Invalidate the cached menu command
        let s:tlist_{fidx}_menu_cmd = ''
    endif

    " Update the taglist, menu and window
    call s:Tlist_Update_Current_File()
endfunction

" Tlist_Menu_Jump_To_Tag
" Jump to the selected tag
function! s:Tlist_Menu_Jump_To_Tag(tidx)
    let fidx = s:Tlist_Get_File_Index(fnamemodify(bufname('%'), ':p'))
    if fidx == -1
        return
    endif

    let tagpat = s:Tlist_Get_Tag_SearchPat(fidx, a:tidx)
    if tagpat == ''
        return
    endif

    " Add the current cursor position to the jump list, so that user can
    " jump back using the ' and ` marks.
    mark '

    silent call search(tagpat, 'w')

    " Bring the line to the middle of the window
    normal! z.

    " If the line is inside a fold, open the fold
    if foldclosed('.') != -1
        .foldopen
    endif
endfunction

" Tlist_Menu_Init
" Initialize the taglist menu
function! s:Tlist_Menu_Init()
    call s:Tlist_Menu_Add_Base_Menu()

    " Automatically add the tags defined in the current file to the menu
    augroup TagListMenuCmds
        autocmd!

        if !g:Tlist_Process_File_Always
            autocmd BufEnter * call s:Tlist_Refresh()
        endif
        autocmd BufLeave * call s:Tlist_Menu_Remove_File()
    augroup end

    call s:Tlist_Menu_Update_File(0)
endfunction

" Tlist_Vim_Session_Load
" Initialize the taglist window/buffer, which is created when loading
" a Vim session file.
function! s:Tlist_Vim_Session_Load()
    call s:Tlist_Log_Msg('Tlist_Vim_Session_Load')

    " Initialize the taglist window
    call s:Tlist_Window_Init()

    " Refresh the taglist window
    call s:Tlist_Window_Refresh()
endfunction

" Tlist_Set_App
" Set the name of the external plugin/application to which taglist
" belongs.
" Taglist plugin is part of another plugin like cream or winmanager.
function! Tlist_Set_App(name)
    if a:name == ""
        return
    endif

    let s:tlist_app_name = a:name
endfunction

" Winmanager integration

" Initialization required for integration with winmanager
function! TagList_Start()
    " If current buffer is not taglist buffer, then don't proceed
    if bufname('%') != '__Tag_List__'
        return
    endif

    call Tlist_Set_App('winmanager')

    " Get the current filename from the winmanager plugin
    let bufnum = WinManagerGetLastEditedFile()
    if bufnum != -1
        let filename = fnamemodify(bufname(bufnum), ':p')
        let ftype = s:Tlist_Get_Buffer_Filetype(bufnum)
    endif

    " Initialize the taglist window, if it is not already initialized
    if !exists('s:tlist_window_initialized') || !s:tlist_window_initialized
        call s:Tlist_Window_Init()
        call s:Tlist_Window_Refresh()
        let s:tlist_window_initialized = 1
    endif

    " Update the taglist window
    if bufnum != -1
        if !s:Tlist_Skip_File(filename, ftype) && g:Tlist_Auto_Update
            call s:Tlist_Window_Refresh_File(filename, ftype)
        endif
    endif
endfunction

function! TagList_IsValid()
    return 0
endfunction

function! TagList_WrapUp()
    return 0
endfunction

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
