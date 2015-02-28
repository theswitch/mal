! Copyright (C) 2015 theswitch

USING: kernel vectors math math.parser strings sequences combinators ;
IN: mal.printer

: str-form ( mal -- str )
    {
        { [ dup number? ] [ number>string ] }
        { [ dup string? ] [ ] }
        { [ dup vector? ]
            [
                [ str-form ] map " " join
                "(" ")" surround
            ]
        }
        [ drop "" ]
    } cond ;
