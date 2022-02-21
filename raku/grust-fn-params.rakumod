our class FnDecl {
    has $.fn_anon_params_with_self;
    has $.fn_params;
    has $.fn_params_allow_variadic;
    has $.fn_params_with_self;
    has $.ret_ty;
}

our class SelfLower {
    has $.maybe_ty_ascription;
    has $.maybe_comma_anon_params;
    has $.maybe_comma_params;
    has $.maybe_mut;
}

our class SelfRegion {
    has $.maybe_comma_anon_params;
    has $.maybe_comma_params;
    has $.lifetime;
    has $.maybe_mut;
    has $.maybe_ty_ascription;
}

our class SelfStatic {
    has $.maybe_params;
    has $.maybe_anon_params;
}

our class FnParams::G {

    rule fn-decl_allow_variadic {
        <fn-params_allow_variadic> <ret-ty>
    }

    proto rule fn-params_allow_variadic { * }

    rule fn-params_allow_variadic:sym<a> {
        '(' ')'
    }

    rule fn-params_allow_variadic:sym<b> {
        '(' <params> ')'
    }

    rule fn-params_allow_variadic:sym<c> {
        '(' <params> ',' ')'
    }

    rule fn-params_allow_variadic:sym<d> {
        '(' <params> ',' <DOTDOTDOT> ')'
    }

    rule fn-params {
        '(' <maybe-params> ')'
    }

    proto rule fn-anon_params { * }

    rule fn-anon_params:sym<a> {
        '(' <anon-param> <anon-params_allow_variadic_tail> ')'
    }

    rule fn-anon_params:sym<b> {
        '(' ')'
    }

    proto rule fn-params_with_self { * }

    rule fn-params_with_self:sym<a> {
        '(' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_params> ')'
    }

    rule fn-params_with_self:sym<b> {
        '(' '&' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_params> ')'
    }

    rule fn-params_with_self:sym<c> {
        '(' '&' <lifetime> <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_params> ')'
    }

    rule fn-params_with_self:sym<d> {
        '(' <maybe-params> ')'
    }

    proto rule fn-anon_params_with_self { * }

    rule fn-anon_params_with_self:sym<a> {
        '(' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_anon_params> ')'
    }

    rule fn-anon_params_with_self:sym<b> {
        '(' '&' <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_anon_params> ')'
    }

    rule fn-anon_params_with_self:sym<c> {
        '(' '&' <lifetime> <maybe-mut> <SELF> <maybe-ty_ascription> <maybe-comma_anon_params> ')'
    }

    rule fn-anon_params_with_self:sym<d> {
        '(' <maybe-anon_params> ')'
    }
}

our class FnParams::A {

    method fn-decl_allow_variadic($/) {
        make FnDecl.new(
            fn-params_allow_variadic =>  $<fn-params_allow_variadic>.made,
            ret-ty                   =>  $<ret-ty>.made,
        )
    }

    method fn-params_allow_variadic:sym<a>($/) {
        MkNone<140402526985760>
    }

    method fn-params_allow_variadic:sym<b>($/) {
        make $<params>.made
    }

    method fn-params_allow_variadic:sym<c>($/) {
        make $<params>.made
    }

    method fn-params_allow_variadic:sym<d>($/) {
        make $<params>.made
    }

    method fn-params($/) {
        make $<maybe_params>.made
    }

    method fn-anon_params:sym<a>($/) {
        ExtNode<140218049450816>
    }

    method fn-anon_params:sym<b>($/) {
        MkNone<140218049468352>
    }

    method fn-params_with_self:sym<a>($/) {
        make SelfLower.new(
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-comma_params  =>  $<maybe-comma_params>.made,
        )
    }

    method fn-params_with_self:sym<b>($/) {
        make SelfRegion.new(
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-comma_params  =>  $<maybe-comma_params>.made,
        )
    }

    method fn-params_with_self:sym<c>($/) {
        make SelfRegion.new(
            lifetime            =>  $<lifetime>.made,
            maybe-mut           =>  $<maybe-mut>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-comma_params  =>  $<maybe-comma_params>.made,
        )
    }

    method fn-params_with_self:sym<d>($/) {
        make SelfStatic.new(
            maybe-params =>  $<maybe-params>.made,
        )
    }

    method fn-anon_params_with_self:sym<a>($/) {
        make SelfLower.new(
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty_ascription     =>  $<maybe-ty_ascription>.made,
            maybe-comma_anon_params =>  $<maybe-comma_anon_params>.made,
        )
    }

    method fn-anon_params_with_self:sym<b>($/) {
        make SelfRegion.new(
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty_ascription     =>  $<maybe-ty_ascription>.made,
            maybe-comma_anon_params =>  $<maybe-comma_anon_params>.made,
        )
    }

    method fn-anon_params_with_self:sym<c>($/) {
        make SelfRegion.new(
            lifetime                =>  $<lifetime>.made,
            maybe-mut               =>  $<maybe-mut>.made,
            maybe-ty_ascription     =>  $<maybe-ty_ascription>.made,
            maybe-comma_anon_params =>  $<maybe-comma_anon_params>.made,
        )
    }

    method fn-anon_params_with_self:sym<d>($/) {
        make SelfStatic.new(
            maybe-anon_params =>  $<maybe-anon_params>.made,
        )
    }
}
