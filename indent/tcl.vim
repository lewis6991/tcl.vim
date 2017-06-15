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

    let l:context = reverse(map(synstack(v:lnum, 1), 'synIDattr(v:val, "name")'))

    let l:indent_level = 0

    for item in l:context
        if    item == "tclProcBody" ||
            \ item == "tclNamespaceEvalBody" ||
            \ item == "tclBlockBody" ||
            \ item == "tclCmdSubBlockBody"
            let l:indent_level += 1
        endif
    endfor

    let l:line = getline(v:lnum)
    let l:prev_line = getline(prevnonblank(v:lnum-1))

    if    l:line =~ '^\s*[}\]]' ||
        \ l:line =~ '^\s*}\s*\(else\(if\)\?\s*\)\?{\s*$'
        let l:indent_level -= 1
    endif

    if l:prev_line =~ '\\s*$'
        let l:indent_level += 1
    endif

    return l:indent_level * &sw
endfunction
