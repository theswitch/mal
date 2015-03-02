! Copyright (C) 2015 theswitch

USING: kernel vectors math math.parser strings sequences
       combinators prettyprint pairs accessors mal.reader ;
IN: mal.printer

: str-form ( mal -- str )
    {
        { [ dup key>> integer-t = ] [ value>> number>string ] }
        { [ dup key>> string-t = ]  [ value>> unparse ] }
        { [ dup key>> atom-t = ]    [ value>> ] }
        { [ dup key>> list-t = ]
            [
                value>> [ str-form ] map " " join
                "(" ")" surround
            ]
        }
        [ drop "" ]
    } cond ;
