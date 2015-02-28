! Copyright (C) 2015 theswitch

USING: kernel io peg mal.reader mal.printer ;
IN: mal.step1-read-print

: READ ( str -- mal ) read-form parse ;

: EVAL ( mal -- mal ) ;

: PRINT ( mal -- str ) str-form ;

: rep ( str -- str ) READ EVAL PRINT ;

: main ( -- )
    [ readln dup [ rep print t ] when ] loop ;

MAIN: main
