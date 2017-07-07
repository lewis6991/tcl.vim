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

let s:indent_syntax_ids = [
    \     "tclBlock",
    \     "tclBlockBody",
    \     "tclNamespaceEvalBody",
    \     "tclProcBody",
    \     "tclCmdSubBlockBody"
    \ ]

let s:no_indent_syntax_ids = [
    \     "tclString",
    \     "tclStringCurly",
    \ ]

function! GetTclIndent()
    if v:lnum == 1
        return 0
    endif

    let l:context = reverse(map(synstack(v:lnum, 1), 'synIDattr(v:val, "name")'))

    let l:indent_level = 0


    if index(s:no_indent_syntax_ids, l:context[0]) >= 0
        return indent(v:lnum)
    endif

    for item in l:context
        if index(s:indent_syntax_ids, item) >= 0
            let l:indent_level += 1
        endif
    endfor

    let l:line = getline(v:lnum)
    let l:prev_line = getline(prevnonblank(v:lnum-1))

    if l:line =~ '^\s*[}\]]' " De-indent on }, ]
        let l:indent_level -= 1
    endif

    if l:prev_line =~ '\\s*$'
        let l:indent_level += 1
    endif

    return l:indent_level * &sw
endfunction
