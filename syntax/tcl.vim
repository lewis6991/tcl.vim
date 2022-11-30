" Vim syntax file
" Language:     Tcl
" Maintainer:   Lewis Russell <lewis6991@gmail.com>
" Last Change:  2017 Jun 23
" Version:      1.2

if exists("b:current_syntax")
    finish
endif

syntax sync fromstart

"-------------------------------------------------------------------------------
" Keywords
"-------------------------------------------------------------------------------
syn keyword tclConditional if then else elseif switch
syn keyword tclLooping     while for foreach
syn keyword tclExceptions  catch error throw try finally

syn keyword tclStatement   return eval continue break
syn keyword tclStatement   after append auto_execok auto_import auto_load
syn keyword tclStatement   auto_qualify auto_reset expr
syn keyword tclStatement   bgerror binary cd chan clock close concat dde dict encoding
syn keyword tclStatement   eof exec exit fblocked fconfigure fcopy file
syn keyword tclStatement   fileevent flush gets glob history http
syn keyword tclStatement   incr interp join lindex linsert list
syn keyword tclStatement   llength load lrange lreplace lsearch lset memory
syn keyword tclStatement   msgcat open parray pid
syn keyword tclStatement   pwd read registry regsub rename resource
syn keyword tclStatement   scan seek socket split subst tell time trace
syn keyword tclStatement   unknown unset update uplevel upvar vwait
syn keyword tclStatement   exist env source global set unset puts lappend variable

syn keyword tclStatement package
    \ nextgroup=tclPackageOption,tclOptionError
    \ skipwhite skipempty

syn keyword tclPackageOption
    \ forget ifneeded names prefer present provide require unknown vcompare
    \ versions vsatisfies

syn keyword tclStatement namespace
    \ nextgroup=tclNamespaceOption,tclOptionError
    \ skipwhite skipempty

syn keyword tclNamespaceOption
    \ children code current delete ensemble eval exists export forget import
    \ inscope origin parent path qualifiers tail unknown upvar which

syn keyword tclStatement info
    \ nextgroup=tclInfoOption,tclOptionError
    \ skipwhite skipempty

syn keyword tclInfoOption
    \ args body class cmdcount commands complete coroutine default errorstack
    \ exists frame functions globals hostname level library loaded locals
    \ nameofexecutable object patchlevel procs script sharedlibextension
    \ tclversion or vars

syn match tclOptionError "\a[a-zA-Z0-9_]*" contained

syn match tclNamespace "$\(\(::\)\?\([a-zA-Z0-9_]*::\)*\)\a[a-zA-Z0-9_]*"
syn match tclNamespace "${[^}]*}" extend

syn keyword tclTodo contained TODO

" String and Character constants
" Highlight special characters (those which have a backslash) differently
syn match tclSpecial "\\\d\d\d\="
syn match tclSpecial "\\."
syn match tclSpecial "\\." contained containedin=ALLBUT,tclSpecial extend contains=NONE

syn region tclString
    \ start=+"+
    \ end=+"+
    \ contains=tclSpecial,tclLineContinue,tclCmdSubBlockBody,tclNamespace
    \ containedin=ALLBUT,tclComment,tclString,tclString1,tclSpecial,tclLitBlock
    \ extend

syn region tclString1
    \ start=+^\s*\zs"+
    \ end=+"+
    \ contains=tclSpecial,tclLineContinue,tclCmdSubBlockBody,tclNamespace
    \ containedin=ALLBUT,tclComment,tclString,tclString1,tclSpecial,tclLitBlock
    \ extend

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

syn match tclOperator  "[(){}[\]/]"
syn match tclComment   "\(^\|;\)\s*\zs#.*" contains=tclTodo,@Spell extend


"-------------------------------------------------------------------------------
" Proc folding
"-------------------------------------------------------------------------------
" Make proc a keyword for some colour variation.
syn keyword tclProc proc nextgroup=tclProcName skipwhite skipempty

syn match tclProcName "[a-zA-Z0-9_:]\+" contained nextgroup=tclProcArgs,tclProcArg skipwhite skipempty

syn region tclProcArgs
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ contains=tclBlockBody
    \ nextgroup=tclProcBody skipwhite skipempty
    \ extend
    \ fold

syn match tclProcArg
    \ "\k\w*"
    \ nextgroup=tclProcBody skipwhite skipempty
    \ contained
    \ containedin=NONE

syn region tclProcBody
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ transparent
    \ keepend
    \ extend
    \ fold

"-------------------------------------------------------------------------------
" tepam::procedure folding
"-------------------------------------------------------------------------------
syn match tclTepamProc "tepam::procedure" nextgroup=tclTepamProcName skipwhite skipempty
syn match tclTepamProcName "[a-zA-Z0-9_:]\+\|{.*}" contained nextgroup=tclTepamProcArgs skipwhite skipempty

syn region tclTepamProcArgs
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ contains=tclBlockBody
    \ nextgroup=tclProcBody skipwhite skipempty
    \ extend
    \ fold

"-------------------------------------------------------------------------------
" Namespace folding
"-------------------------------------------------------------------------------
" Make proc a keyword for some colour variation.
syn match tclKeyword "namespace\s\+eval" nextgroup=tclNamespaceEvalName skipwhite skipempty

syn match tclNamespaceEvalName "\(\w\|::\)\+" contained nextgroup=tclNamespaceEvalBody skipwhite skipempty

syn region tclNamespaceEvalBody
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ transparent
    \ extend
    \ fold

syn match tclStatement "regexp" nextgroup=tclLitBlock skipwhite skipempty

syn region tclLitBlock
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ contains=NONE
    \ contained
    \ extend

"-------------------------------------------------------------------------------
" Block folding
"-------------------------------------------------------------------------------
syn region tclBlockBody
    \ matchgroup=tclBlock
    \ start="{"
    \ end="}"
    \ transparent
    \ keepend
    \ extend

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
hi def link tclStatement       Statement
hi def link tclKeyword         Keyword
hi def link tclConditional     Conditional
hi def link tclLooping         Repeat
hi def link tclNumber          Number
hi def link tclString          String
hi def link tclString1         String
hi def link tclComment         Comment
hi def link tclSpecial         Special
hi def link tclTodo            Todo
hi def link tclExceptions      Exception
hi def link tclNamespace       Identifier
hi def link tclLineContinue    Special
hi def link tclOperator        Special
hi def link tclBlock           Special
hi def link tclCmdSubBlock     Special
hi def link tclProc            Statement
hi def link tclNamespaceOption Statement
hi def link tclPackageOption   Statement
hi def link tclInfoOption      Statement
hi def link tclOptionError     Error

let b:current_syntax = "tcl"

"-------------------------------------------------------------------------------
