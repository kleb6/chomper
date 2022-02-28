use grust-model;

#-------------------------------------

our role PathExpr::Rules {

    proto rule path-expr { * }

    rule path-expr:sym<b> { <MOD-SEP>? <path-generic-args-with-colons> }
    rule path-expr:sym<c> { <SELF> <MOD-SEP> <path-generic-args-with-colons> }
}

our role PathExpr::Actions {

    method path-expr:sym<b>($/) {
        make $<path-generic-args-with-colons>.made
    }

    method path-expr:sym<c>($/) {
        make SelfPath.new(
            path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
        )
    }
}

