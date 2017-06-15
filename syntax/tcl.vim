" Vim syntax file
" Language:     Tcl
" Maintainer:   Lewis Russell <lewis6991@gmail.com>
" Last Change:  2016 Jul 20
" Version:      1.0

if exists("b:current_syntax")
    finish
else
    let b:current_syntax = "tcl"
endif

"-------------------------------------------------------------------------------
" Keywords
"-------------------------------------------------------------------------------
syn keyword tclConditional if then else elseif switch
syn keyword tclLooping     while for foreach continue break
syn keyword tclExceptions  catch error throw try finally

syn keyword tclStatement   return after append auto_execok auto_import auto_load
syn keyword tclStatement   auto_qualify auto_reset expr
syn keyword tclStatement   bgerror binary cd chan clock close concat dde dict encoding
syn keyword tclStatement   eof eval exec exit fblocked fconfigure fcopy file
syn keyword tclStatement   fileevent flush gets glob history http
syn keyword tclStatement   incr info interp join lindex linsert list
syn keyword tclStatement   llength load lrange lreplace lsearch lset memory
syn keyword tclStatement   msgcat open parray pid
syn keyword tclStatement   pwd read regexp registry regsub rename resource
syn keyword tclStatement   scan seek socket split subst tell time trace
syn keyword tclStatement   unknown unset update uplevel upvar vwait
syn keyword tclStatement   exist env source global set unset puts lappend

syn match tclNamespace "$\(\(::\)\?\([[:alnum:]_]*::\)*\)\a[a-zA-Z0-9_]*"
syn match tclNamespace "${[^}]*}"

syn keyword tclTodo contained TODO

" String and Character constants
" Highlight special characters (those which have a backslash) differently
syn match tclSpecial contained "\\\d\d\d\=\|\\."

syn region tclString start=+"+ end=+"+ contains=tclSpecial,tclLineContinue skip=+\\\\\|\\"+ extend
syn region tclString start=+[^\\]"+ms=s+1  end=+"+ contains=tclSpecial,tclLineContinue skip=+\\\\\|\\"+ extend

syn match tclLineContinue "\\\s*$"

"-------------------------------------------------------------------------------
" Numbers
"-------------------------------------------------------------------------------
" integer number, or floating point number without a dot and with "f".
syn case ignore

syn match tclNumber   "\<\d\+\(u\=l\=\|lu\|f\)\>"

" floating point number, with dot, optional exponent
syn match tclNumber      "\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"

" floating point number, starting with a dot, optional exponent
syn match tclNumber      "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"

" floating point number, without dot, with exponent
syn match tclNumber   "\<\d\+e[-+]\=\d\+[fl]\=\>"

" hex number
syn match tclNumber   "0x[0-9a-f]\+"

syn case match

syn match tclOperator  "[(){}\[\]/]"
syn match tclComment   "\(^\|;\)\s*\zs#.*" contains=tclTodo,@Spell


"-------------------------------------------------------------------------------
" Proc folding
"-------------------------------------------------------------------------------
" Make proc a keyword for some colour variation.
syn keyword tclKeyword     proc nextgroup=tclProcName skipwhite skipempty

syn match tclProcName "\w\+" contained nextgroup=tclProcArgs skipwhite skipempty

syn region tclProcArgs
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ nextgroup=tclProcBody skipwhite skipempty

syn region tclProcBody
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ transparent
    \ fold

"-------------------------------------------------------------------------------
" Namespace folding
"-------------------------------------------------------------------------------
" Make proc a keyword for some colour variation.
syn match tclKeyword "namespace\s\+eval" nextgroup=tclNamespaceEvalName skipwhite skipempty

syn match tclNamespaceEvalName "\w\+" contained nextgroup=tclNamespaceEvalBody skipwhite skipempty

syn region tclNamespaceEvalBody
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ transparent
    \ fold

"-------------------------------------------------------------------------------
" Block folding
"-------------------------------------------------------------------------------
syn region tclBlockBody
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ transparent

syn region tclCmdSubBlockBody
    \ matchgroup=tclCmdSubBlock
    \ start="\["
    \ end="\]"
    \ transparent

"-------------------------------------------------------------------------------

set foldmethod=syntax

"-------------------------------------------------------------------------------
" Highlight
"-------------------------------------------------------------------------------
hi def link tclStatement    Statement
hi def link tclKeyword      Keyword
hi def link tclConditional  Conditional
hi def link tclLooping      Repeat
hi def link tclNumber       Number
hi def link tclString       String
hi def link tclComment      Comment
hi def link tclSpecial      Special
hi def link tclTodo         Todo
hi def link tclLineContinue WarningMsg
hi def link tclExceptions   Exception
hi def link tclNamespace    Identifier
hi def link tclOperator     Special
hi def link tclBlock        Special
hi def link tclCmdSubBlock  Special

"-------------------------------------------------------------------------------
