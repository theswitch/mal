! Copyright (C) 2015 theswitch

USING: kernel io ;
IN: mal.step0-repl

: READ ( str -- str ) ;

: EVAL ( str -- str ) ;

: PRINT ( str -- str ) ;

: rep ( str -- str ) READ EVAL PRINT ;

: main ( -- )
    [ readln dup [ rep print t ] when ] loop ;

MAIN: main
