! Copyright (C) 2015 theswitch

USING: kernel peg peg.parsers strings strings.parser sequences
       make pairs ;
IN: mal.reader

DEFER: read-form
SYMBOLS: list-t integer-t atom-t string-t ;

: read-list ( -- parser ) 
    read-form repeat0 epsilon sp hide 2seq [ first ] action
    "(" ")" surrounded-by ;

: read-atom ( -- parser )
    "a-z+*/-" range-pattern repeat1 [ >string ] action ;

: read-integer ( -- parser ) 'integer' ;

: read-string ( -- parser )
    [
        [ CHAR: " = ] satisfy hide ,
        ! read an escape sequence
        [ CHAR: \ = ] satisfy hide any-char 2seq
            [ first escape ] action
        ! read a normal string char
        [ CHAR: " = not ] satisfy 2choice repeat0 ,
        [ CHAR: " = ] satisfy hide ,
    ] seq* [ first >string ] action ;

: read-form ( -- parser )
    [
        read-string  [ string-t  <pair> ] action
        read-integer [ integer-t <pair> ] action
        read-atom    [ atom-t    <pair> ] action
        read-list    [ list-t    <pair> ] action

        4choice sp
    ] delay ;
