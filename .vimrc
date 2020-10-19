"       ~_
"    ~_ )_)~_
"    )_))_))_)
"    _!__!__!_
"  ~~\t  Gemu/~~

"  File Name: .vimrc
"  Purpose: set VIM personal settings
"  Creation Date: 04-10-20
"  Created By: Andrea Andreu Salvagnin

"Basics higlights
syntax on

"Mute bell
set noerrorbells

"Tab long 4 char
set tabstop=8

set smartindent

"shows line number
set nu

set smartcase

"no backup and put everything on undo director
set nobackup
set undodir=~/.vim/undodir

"Shows where pattern matches
set incsearch

set path+=**

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


"CUSTOM FUNCTIONS:

"https://vim.fandom.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e

function! s:insert_logo()
  let line_0_logo ="*        ~_"
  let line_1_logo ="*     ~_ )_)~_"
  let line_2_logo ="*     )_))_))_)" 
  let line_3_logo ="*     _!__!__!_"
  let line_4_logo ="*   ~~\\t  Gemu/~~"

  execute "normal! o" . line_0_logo
  execute "normal! o" . line_1_logo
  execute "normal! o" . line_2_logo
  execute "normal! o" . line_3_logo
  execute "normal! o" . line_4_logo
  execute "normal! o*"

endfunction

function! s:insert_custom_header(author_name)
  let _start_comment = "/*"
  let _end_comment = "*/"

  let _author_name = a:author_name
  let _file_name = expand("%:t")
  
  let _date = strftime("%d-%m-%y")

  execute "normal! i" . _start_comment

  call <SID>insert_logo()

  execute "normal! o*  File Name: " . _file_name
  execute "normal! o*  Purpose: "
  execute "normal! o*  Creation Date: " . _date
  execute "normal! o*  Created By: " . _author_name
  
  execute "normal! o" . _end_comment
  execute "normal! o"

endfunction



function! s:insert_gates()
  let gatename = substitute(expand("%:t"), "\\.", "_", "g")
  execute "normal! o#ifndef " . gatename
  execute "normal! o#define " . gatename 
  execute "normal! o"
  execute "normal! o"
  execute "normal! o"
  execute "normal! Go#endif /* " . gatename . " */"
endfunction

function! s:custom_cpp_header()
  call <SID>insert_custom_header("Andrea Andreu Salvagnin")
  execute "normal! o"
endfunction

"Add header and gates to h files
function! s:custom_cpp_h_header()
	call <SID>insert_custom_header("Andrea Andreu Salvagnin")
	call <SID>insert_gates()
	execute "normal! 2k<CR>" 

endfunction


autocmd BufNewFile *.{h,hpp} call <SID>custom_cpp_h_header()


autocmd BufNewFile *.{cpp,cc} call <SID>custom_cpp_header()




