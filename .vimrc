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
" Name of the author for custom headers
let g:g_author="Andrea Andreu Salvagnin"

"https://vim.fandom.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e


function! s:insert_logo(comment)
  let _comment = a:comment
  let line_0_logo ="        ~_"
  let line_1_logo ="     ~_ )_)~_"
  let line_2_logo ="     )_))_))_)"
  let line_3_logo ="     _!__!__!_"
  let line_4_logo ="   ~~\\t  Gemu/~~"
  let line_5_logo ="    ~GEAR~GEAR~"

  execute "normal! o" . _comment . line_0_logo
  execute "normal! o" . _comment . line_1_logo
  execute "normal! o" . _comment . line_2_logo
  execute "normal! o" . _comment . line_3_logo
  execute "normal! o" . _comment . line_4_logo
  execute "normal! o" . _comment . line_5_logo
  execute "normal! o" . _comment
endfunction

function! s:insert_custom_header(author_name, start_comment, comment, end_comment)
  let _start_comment = a:start_comment
  let _comment = a:comment
  let _end_comment = a:end_comment

  let _author_name = a:author_name
  let _file_name = expand("%:t")

  let _date = strftime("%d-%m-%y")

  execute "normal! i" . _start_comment

  call <SID>insert_logo(_comment)

  execute "normal! o" . _comment . "  File Name: " . _file_name
  execute "normal! o" . _comment . "  Purpose: "
  execute "normal! o" . _comment . "  Creation Date: " . _date
  execute "normal! o" . _comment . "  Created By: " . _author_name

  execute "normal! o" . _end_comment
  execute "normal! o"
endfunction


function! s:insert_gates_and_class()
  let gatename = substitute(expand("%:t"), "\\.", "_", "g")
  execute "normal! o#ifndef " . gatename
  execute "normal! o#define " . gatename
  execute "normal! o"
  execute "normal! o"
  execute "normal! o" . "class " . expand("%:r")
  execute "normal! o" . "{"
  execute "normal! o"
  execute "normal! o" . "};"
  execute "normal! o"
  execute "normal! Go#endif /* " . gatename . " */"
endfunction


function! s:custom_cpp_header(author)
  call <SID>insert_custom_header(a:author, "/*", "*", "*/")
  execute "normal! o"
  execute "normal! o" . "#include \"" . expand("%:r") . ".hpp\""
  execute "normal! o"
  execute "normal! o"
endfunction

"Add header, gates and define a class to h/hpp files
function! s:custom_h_hpp_header(author)
  call <SID>insert_custom_header(a:author, "/*", "*", "*/")
  call <SID>insert_gates_and_class()
  execute "normal! 2k<CR>"

endfunction


function! s:custom_tex_header(author)
  call <SID>insert_custom_header(a:author, "%", "%", "%")
  execute "normal! o"
endfunction

"Insert clean in makefile
function! s:insert_clean()
  execute "normal! o.PHONY: clean"
  execute "normal! oclean:"
  execute "normal! o#remeber to define rm command and mind the initial tab"
endfunction


function! s:custom_makefile_header(author)
  call <SID>insert_custom_header(a:author, "#", "#", "#")
  call <SID>insert_clean()
  execute "normal! o"
endfunction


autocmd BufNewFile *.{h,hpp} call <SID>custom_h_hpp_header(g_author)

autocmd BufNewFile *.{cpp} call <SID>custom_cpp_header(g_author)

autocmd BufnewFile *.{tex} call <SID>custom_tex_header(g_author)

autocmd BufnewFile makefile call <SID>custom_makefile_header(g_author)
autocmd BufnewFile makefile.* call <SID>custom_makefile_header(g_author)
autocmd BufnewFile *.makefile call <SID>custom_makefile_header(g_author)

