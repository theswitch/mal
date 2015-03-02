! Copyright (C) 2015 theswitch

USING: kernel peg peg.parsers strings strings.parser sequences
       make pairs ;
IN: mal.reader

DEFER: read-form
SYMBOLS: list-t integer-t atom-t string-t ;

: read-list ( -- parser ) 
    read-form repeat0 epsilon sp hide 2seq
        [ first list-t <pair> ] action
    "(" ")" surrounded-by ;

: read-atom ( -- parser )
    'integer' [ integer-t <pair> ] action
    "a-z+*" range-pattern repeat1
        [ >string atom-t <pair> ] action
    2choice ;

: read-string ( -- parser )
    [
        [ CHAR: " = ] satisfy hide ,
        ! read an escape sequence
        [ CHAR: \ = ] satisfy hide any-char 2seq
            [ first escape ] action
        ! read a normal string char
        [ CHAR: " = not ] satisfy 2choice repeat0 ,
        [ CHAR: " = ] satisfy hide ,
    ] seq* [ first >string string-t <pair> ] action ;

: read-form ( -- parser )
    [ read-string read-atom read-list 3choice sp ] delay ;
