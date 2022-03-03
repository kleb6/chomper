use grust-model;

our role LambdaExpr::Rules {

    #---------------------
    proto rule lambda-expr { * }

    rule lambda-expr:sym<a> {
        <tok-oror> <ret-ty> <expr>
    }

    rule lambda-expr:sym<b> {
        '|' '|' <ret-ty> <expr>
    }

    rule lambda-expr:sym<c> {
        '|' <inferrable-params> '|' <ret-ty> <expr>
    }

    rule lambda-expr:sym<d> {
        '|' <inferrable-params> <tok-oror> <lambda-expr-no-first-bar>
    }

    #---------------------
    proto rule lambda-expr-no-first-bar { * }

    rule lambda-expr-no-first-bar:sym<a> {
        '|' 
        <ret-ty> 
        <expr>
    }

    rule lambda-expr-no-first-bar:sym<b> {
        <inferrable-params> 
        '|' 
        <ret-ty> 
        <expr>
    }

    rule lambda-expr-no-first-bar:sym<c> {
        <inferrable-params> 
        <tok-oror> 
        <lambda-expr-no-first-bar>
    }

    #---------------------
    proto rule lambda-expr-nostruct { * }

    rule lambda-expr-nostruct:sym<a> {
        <tok-oror> 
        <expr-nostruct>
    }

    rule lambda-expr-nostruct:sym<b> {
        '|' '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr-nostruct:sym<c> {
        '|' <inferrable-params> '|' <expr-nostruct>
    }

    rule lambda-expr-nostruct:sym<d> {
        '|' 
        <inferrable-params> 
        <tok-oror> 
        <lambda-expr-nostruct-no-first-bar>
    }

    #---------------------
    proto rule lambda-expr-nostruct-no-first-bar { * }

    rule lambda-expr-nostruct-no-first-bar:sym<a> {
        '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr-nostruct-no-first-bar:sym<b> {
        <inferrable-params> 
        '|' <ret-ty> <expr-nostruct>
    }

    rule lambda-expr-nostruct-no-first-bar:sym<c> {
        <inferrable-params> 
        <tok-oror> 
        <lambda-expr-nostruct-no-first-bar>
    }
}

our role LambdaExpr::Actions {

    method lambda-expr:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<b>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr              =>  $<expr>.made,
        )
    }

    method lambda-expr:sym<d>($/) {
        make ExprFnBlock.new(
            inferrable-params        =>  $<inferrable-params>.made,
            lambda-expr-no-first-bar =>  $<lambda-expr-no-first-bar>.made,
        )
    }

    method lambda-expr-no-first-bar:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty =>  $<ret-ty>.made,
            expr   =>  $<expr>.made,
        )
    }

    method lambda-expr-no-first-bar:sym<b>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr              =>  $<expr>.made,
        )
    }

    method lambda-expr-no-first-bar:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params        =>  $<inferrable-params>.made,
            lambda-expr-no-first-bar =>  $<lambda-expr-no-first-bar>.made,
        )
    }

    method lambda-expr-nostruct:sym<a>($/) {
        make ExprFnBlock.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr-nostruct:sym<b>($/) {
        make ExprFnBlock.new(
            ret-ty        =>  $<ret-ty>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr-nostruct:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            expr-nostruct     =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr-nostruct:sym<d>($/) {
        make ExprFnBlock.new(
            inferrable-params                 =>  $<inferrable-params>.made,
            lambda-expr-nostruct-no-first-bar =>  $<lambda-expr-nostruct-no-first-bar>.made,
        )
    }

    method lambda-expr-nostruct-no-first-bar:sym<a>($/) {
        make ExprFnBlock.new(
            ret-ty        =>  $<ret-ty>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr-nostruct-no-first-bar:sym<b>($/) {
        make ExprFnBlock.new(
            inferrable-params =>  $<inferrable-params>.made,
            ret-ty            =>  $<ret-ty>.made,
            expr-nostruct     =>  $<expr-nostruct>.made,
        )
    }

    method lambda-expr-nostruct-no-first-bar:sym<c>($/) {
        make ExprFnBlock.new(
            inferrable-params                 =>  $<inferrable-params>.made,
            lambda-expr-nostruct-no-first-bar =>  $<lambda-expr-nostruct-no-first-bar>.made,
        )
    }
}
