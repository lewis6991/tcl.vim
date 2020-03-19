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

if exists('*GetTclIndent')
    finish
endif

let s:indent_syntax_ids = [
    \     'tclBlock',
    \     'tclBlockBody',
    \     'tclNamespaceEvalBody',
    \     'tclProcBody',
    \     'tclProcArgs',
    \ ]


function! GetTclIndent()
    if v:lnum == 1
        return 0
    endif

    let l:context = reverse(map(synstack(v:lnum, 1), 'synIDattr(v:val, "name")'))

    let l:indent_level = 0
    let l:indent_offset = 0

    let l:line = getline(v:lnum)
    let l:prev_line = getline(prevnonblank(v:lnum-1))

    if l:context[0] =~# 'tclString.*'
        if l:prev_line !~# '\\s*$'
            return indent(v:lnum)
        else
            let l:indent_level += 1
            if l:context[0] ==# 'tclString1'
                let l:indent_offset += 1
            endif
        endif
    else
        if l:prev_line =~# '\\s*$'
            let l:indent_level += 1
        endif
    endif

    for item in l:context
        if index(s:indent_syntax_ids, item) >= 0
            let l:indent_level += 1
        endif
    endfor

    if l:context[0] ==# 'tclCmdSubBlockBody'
        \ && l:line =~# '^\s*[}\]]' " De-indent on }, ]
        let l:indent_level -= 1
    elseif l:line =~# '^\s*[}]' " De-indent on }
        let l:indent_level -= 1
    endif

    return l:indent_level * &sw + l:indent_offset
endfunction
