! Copyright (C) 2015 theswitch

USING: kernel peg peg.parsers strings sequences ;
IN: mal.reader

DEFER: read-form

: read-list ( -- parser ) 
    read-form repeat0 epsilon sp hide 2seq [ first ] action
    "(" ")" surrounded-by ;

: read-atom ( -- parser )
    'integer'
    "a-z+*" range-pattern repeat1 [ >string ] action
    2choice ;

: read-form ( -- parser )
    [ read-atom read-list 2choice sp ] delay ;
