" Vim plugin for Modula-2
" Language: Modula-2

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
 
" Case-sensitive: Modula-2 keywords ARE case-sensitive (uppercase).
syntax case match
 
" ── Comments ──────────────────────────────────────────────────────────────────
" Modula-2 comments are (* … *) and they nest.
syntax region  m2Comment  start="(\*"  end="\*)"  contains=m2Comment  fold
highlight default link m2Comment Comment
 
" ── String literals ───────────────────────────────────────────────────────────
syntax region  m2String   start=+"+   end=+"+   oneline
syntax region  m2String   start=+'+   end=+'+   oneline
highlight default link m2String String
 
" ── Numbers ───────────────────────────────────────────────────────────────────
" Decimal, real (3.14E+2)
syntax match   m2Number   '\<\d\+\(\.\d\+\([Ee][+-]\?\d\+\)\?\)\?\>'
syntax match   m2Number   '\<[0-9A-F]\+H\>' " hex   (0FFH)
syntax match   m2Number   '\<[0-7]\+B\>'    " octal (0777B)
highlight default link m2Number Number
 
" ── Built-in types ────────────────────────────────────────────────────────────
syntax keyword m2Type
  \ INTEGER LONGINT SHORTINT CARDINAL LONGCARD SHORTCARD BOOLEAN REAL LONGREAL
  \ SHORTREAL CHAR SHORTCOMPLEX COMPLEX LONGCOMPLEX
  \ PROC
" SYSTEM ISO extension
syntax keyword m2Type
  \ BITSPERLOC LOCSPERWORD LOC BYTE WORD ADDRESS CSIZE_T CSSIZE_T COFF_T
" catch TO and OF as type only in this context, else catch them as keywords
syntax match   m2Type 'ARRAY\s\+\['
syntax match   m2Type '\]\s\+OF'
syntax match   m2Type 'ARRAY\s\+OF'
syntax match   m2Type 'POINTER\s\+TO'
highlight default link m2Type Type
 
" ── Reserved keywords ─────────────────────────────────────────────────────────
syntax keyword m2Keyword
  \ BEGIN BY CASE CONST DEFINITION DO ELSE ELSIF END EXIT
  \ EXPORT FOR FROM IF IMPLEMENTATION IMPORT LOOP MODULE
  \ PROCEDURE QUALIFIED RECORD REPEAT RETURN SET THEN TYPE UNTIL
  \ VAR WHILE WITH TO OF
highlight default link m2Keyword Keyword
 
" ── Built-in constants ────────────────────────────────────────────────────────
syntax keyword m2Constant  TRUE FALSE NIL
highlight default link m2Constant Constant
 
" ── Standard pervasive functions / procedures ─────────────────────────────────
syntax keyword m2Builtin
  \ ABS CAP CHR DEC EXCL FLOAT HIGH INC INCL MIN MAX ODD ORD TRUNC VAL
  \ NEW DISPOSE ALLOCATE DEALLOCATE
  \ HALT
  \ SIZE TSIZE ADR SHIFT ROTATE
highlight default link m2Builtin Function
 
" ── Procedure / function calls ────────────────────────────────────────────────
" Match any identifier immediately followed by '(' that is NOT already
" matched as a keyword/builtin. We use a zero-width look-ahead via \ze to
" colour only the identifier, not the paren itself.
" 'contained' is NOT set so it matches at top level; keywords above take
" priority because syn keyword has higher priority than syn match.
syntax match   m2ProcCall  '\<[A-Za-z_][A-Za-z0-9_.]*\ze\s*('
highlight default link m2ProcCall Function
 
" ── Procedure / module *definition* names ─────────────────────────────────────
" PROCEDURE Foo  or  MODULE Bar  — highlight the name token after the keyword.
syntax match   m2DefName   '\(\<PROCEDURE\>\s\+\)\@<=[A-Za-z_][A-Za-z0-9_]*'
syntax match   m2DefName   '\(\<END\>\s\+\)\@<=[A-Za-z_][A-Za-z0-9_]*'
syntax match   m2DefName   '\(\<MODULE\>\s\+\)\@<=[A-Za-z_][A-Za-z0-9_]*'
syntax match   m2DefName   '\(\<DEFINITION\s\+MODULE\>\s\+\)\@<=[A-Za-z_][A-Za-z0-9_]*'
syntax match   m2DefName   '\(\<IMPLEMENTATION\s\+MODULE\>\s\+\)\@<=[A-Za-z_][A-Za-z0-9_]*'
highlight default link m2DefName Identifier
 
" ── Operators and punctuation ─────────────────────────────────────────────────
syntax match   m2Operator  '[+\-*/&|~#<>^]'
syntax match   m2Operator  '\.\.'
syntax match   m2Operator  '[^:]\zs=' " not if in ':='
syntax keyword m2Operator  MOD DIV IN AND OR NOT
highlight default link m2Operator Operator
 
let b:current_syntax = "modula2"
