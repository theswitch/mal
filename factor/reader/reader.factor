! Copyright (C) 2015 theswitch

USING: kernel peg peg.parsers strings strings.parser sequences make ;
IN: mal.reader

DEFER: read-form

: read-list ( -- parser ) 
    read-form repeat0 epsilon sp hide 2seq [ first ] action
    "(" ")" surrounded-by ;

: read-atom ( -- parser )
    'integer'
    "a-z+*" range-pattern repeat1 [ >string ] action
    2choice ;

: read-string ( -- parser )
    [
        [ CHAR: " = ] satisfy hide ,
        [ CHAR: \ = ] satisfy hide any-char 2seq [ first escape ] action
        [ CHAR: " = not ] satisfy 2choice repeat0 ,
        [ CHAR: " = ] satisfy hide ,
    ] seq* [ first >string ] action ;

: read-form ( -- parser )
    [ read-string read-atom read-list 3choice sp ] delay ;
