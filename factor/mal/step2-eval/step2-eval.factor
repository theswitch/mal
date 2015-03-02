! Copyright (C) 2015 theswitch

USING: kernel io peg mal.reader mal.printer math pairs
       sequences accessors assocs combinators ;
IN: mal.step2-eval

! a simple environment of arithmetic functions
CONSTANT: env H{
        { "+" [ 0 [ + ] reduce integer-t <pair> ] }
        { "-" [ 0 [ - ] reduce integer-t <pair> ] }
        { "*" [ 1 [ * ] reduce integer-t <pair> ] }
        { "/" [ 1 [ / ] reduce >integer integer-t <pair> ] }
    }

DEFER: EVAL

: READ ( str -- mal ) read-form parse ;

: eval-ast ( mal env -- mal ) swap
    {
        ! on a symbol, return from the environment
        { [ dup key>> atom-t = ]
          [ value>> swap at atom-t <pair> ] }
        ! eval each of the list members
        { [ dup key>> list-t = ]
          [ value>> [ EVAL ] map list-t <pair> nip ] }
        ! leave other values as they are
        [ nip ]
    } cond ;

: EVAL ( mal -- mal )
    env eval-ast
    ! if the result is a list, apply the tail of the list to
    ! the head
    dup key>> list-t =
    [ value>> [ rest [ value>> ] map ]
      [ first value>> ] bi call( list -- mal ) ] when ;

: PRINT ( mal -- str ) str-form ;

: rep ( str -- str ) READ EVAL PRINT ;

: main ( -- )
    [ readln dup [ rep print t ] when ] loop ;

MAIN: main
