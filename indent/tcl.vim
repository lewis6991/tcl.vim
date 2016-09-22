" Language: Tcl
"
" Credits:
"   Originally created by
"       Lewis Russell <lewis6991@gmail.com>
"

if exists("b:did_indent")
    finish
endif

let b:did_indent = 1

setlocal indentexpr=GetTclIndent()

if exists("*GetTclIndent")
    finish
endif

function! GetTclIndent()
    if v:lnum == 1
        return 0
    endif

    if getline(v:lnum) =~ '^\s*}'
        return indent(s:SearchForBlockStart('{', '', '}', v:lnum))
    elseif getline(v:lnum) =~ '^\s*\]'
        return indent(s:SearchForBlockStart('\[', '', '\]', v:lnum))
    endif

    let l:lnum = prevnonblank(v:lnum - 1)

    if getline(l:lnum) =~ '[[{]\s*$'
        return indent(l:lnum) + &sw
    else
        return indent(l:lnum)
    endif

endfunction

" For any kind of block with a provided end pattern and start pattern, return
" the line of the start of the block.
function! s:SearchForBlockStart(start_wd, mid_wd, end_wd, current_line_no)
    call cursor(a:current_line_no, 1)
    return searchpair(a:start_wd, a:mid_wd, a:end_wd, 'bnW', "")
endfunction
