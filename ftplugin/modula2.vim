" Vim plugin for Modula-2
" Language: Modula-2

" --- Guard --------------------------------------------------------------------
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" --- Filetype basics ----------------------------------------------------------
setlocal commentstring=(*\ %s\ *)
setlocal comments=s1:(*,mb:\ ,ex:*)
setlocal formatoptions+=croq

" --- Smart indent expression --------------------------------------------------
" indentexpr fires for every new line; indentkeys lists the chars that
" re-trigger it while you type (notably 'D' for END, 'E' for ELSE/ELSIF,
" and '=' re-indents the current line when you press =).
setlocal indentexpr=Modula2Indent(v:lnum)
setlocal indentkeys+=0=END,0=ELSE,0=ELSIF,0=UNTIL,0=|

" --- Indent function ----------------------------------------------------------
function! Modula2Indent(lnum)
  " Fall back to zero for the very first line
  if a:lnum <= 1
    return 0
  endif

  " Find the previous non-blank line
  let prev_lnum = prevnonblank(a:lnum - 1)
  if prev_lnum == 0
    return 0
  endif

  let prev_line = getline(prev_lnum)
  let cur_line  = getline(a:lnum)
  let indent    = indent(prev_lnum)
  let sw        = shiftwidth()

  " -- Openers: lines that should increase indent on the NEXT line -------------
  " MODULE, PROCEDURE, BEGIN, THEN, ELSE, ELSIF, DO, OF, REPEAT, LOOP,
  " RECORD, WITH, EXCEPT, FINALLY all open a new block.
  " We match them as whole words at the *end* of the logical line (ignoring
  " trailing comments is hard in pure VimScript, so we match anywhere on
  " the trimmed line — good enough for well-formatted code).
  if prev_line =~# '\<\(TYPE\|VAR\|BEGIN\|THEN\|ELSE\|ELSIF\|DO\|OF\|REPEAT\|LOOP\|RECORD\|WITH\)\>'
    let indent += sw
  endif
  " PROCEDURE / MODULE header line — the body follows after BEGIN, but the
  " declaration line itself should not indent its *own* continuation.  We
  " only indent if the line ends with ';' (forward declaration) — those stay
  " flat.  Lines ending with nothing / comment get a +1 for parameter
  " continuation; we leave that alone here and let autoindent handle it.

  " -- Deindent terminators: cur_line starts with a closer ---------------------
  " These tokens close a block and should be at the *same* level as the
  " matching opener, i.e. one level LESS than the block body.
  if cur_line =~# '^\s*\<\(END\|ELSE\|ELSIF\|UNTIL\)\>'
    let indent -= sw
  endif

  " Never return negative indent
  return max([0, indent])
endfunction


" --- abbreviations ------------------------------------------------------------

if exists("g:modula2_abbr")
  iabbr <buffer> not NOT
  iabbr <buffer> or OR
  iabbr <buffer> and AND
  iabbr <buffer> in IN
  iabbr <buffer> div DIV
  iabbr <buffer> mod MOD
  iabbr <buffer> implementation IMPLEMENTATION
  iabbr <buffer> definition DEFINITION
  iabbr <buffer> module MODULE
  iabbr <buffer> end END
  iabbr <buffer> procedure PROCEDURE
  iabbr <buffer> nil NIL
  iabbr <buffer> false FALSE
  iabbr <buffer> true TRUE
  
  iabbr <buffer> of OF
  iabbr <buffer> to TO
  iabbr <buffer> with WITH
  iabbr <buffer> while WHILE
  iabbr <buffer> var VAR
  iabbr <buffer> until UNTIL
  iabbr <buffer> type TYPE
  iabbr <buffer> then THEN
  iabbr <buffer> set SET
  iabbr <buffer> return RETURN
  iabbr <buffer> repeat REPEAT
  iabbr <buffer> record RECORD
  iabbr <buffer> qualified QUALIFIED
  iabbr <buffer> procedure PROCEDURE
  iabbr <buffer> module MODULE
  iabbr <buffer> loop LOOP
  iabbr <buffer> import IMPORT
  iabbr <buffer> implementation IMPLEMENTATION
  iabbr <buffer> if IF
  iabbr <buffer> from FROM
  iabbr <buffer> for FOR
  iabbr <buffer> export EXPORT
  iabbr <buffer> exit EXIT
  iabbr <buffer> end END
  iabbr <buffer> elsif ELSIF
  iabbr <buffer> else ELSE
  iabbr <buffer> do DO
  iabbr <buffer> definition DEFINITION
  iabbr <buffer> const CONST
  iabbr <buffer> case CASE
  iabbr <buffer> by BY
  iabbr <buffer> begin BEGIN
  
  iabbr <buffer> array ARRAY
  iabbr <buffer> pointer POINTER
  
  iabbr <buffer> coff_t COFF_T
  iabbr <buffer> cssize_t CSSIZE_T
  iabbr <buffer> csize_t CSIZE_T
  iabbr <buffer> address ADDRESS
  iabbr <buffer> word WORD
  iabbr <buffer> byte BYTE
  iabbr <buffer> loc LOC
  iabbr <buffer> locsperword LOCSPERWORD
  iabbr <buffer> bitsperloc BITSPERLOC
  
  iabbr <buffer> proc PROC
  iabbr <buffer> longcomplex LONGCOMPLEX
  iabbr <buffer> complex COMPLEX
  iabbr <buffer> shortcomplex SHORTCOMPLEX
  iabbr <buffer> char CHAR
  iabbr <buffer> shortreal SHORTREAL
  iabbr <buffer> longreal LONGREAL
  iabbr <buffer> real REAL
  iabbr <buffer> boolean BOOLEAN
  iabbr <buffer> shortcard SHORTCARD
  iabbr <buffer> longcard LONGCARD
  iabbr <buffer> cardinal CARDINAL
  iabbr <buffer> shortint SHORTINT
  iabbr <buffer> longint LONGINT
  iabbr <buffer> integer INTEGER
endif
