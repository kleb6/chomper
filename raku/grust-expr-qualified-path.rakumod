use grust-model;

our role ExprQualifiedPath::Rules {

    proto rule expr-qualified-path { * }

    rule expr-qualified-path:sym<a> {
        '<' <ty-sum> <maybe-as-trait-ref> '>' <MOD-SEP> <ident> <maybe-qpath-params>
    }

    rule expr-qualified-path:sym<b> {
        <SHL> <ty-sum> <maybe-as-trait-ref> '>' <MOD-SEP> <ident> <maybe-as-trait-ref> '>' <MOD-SEP> <ident>
    }

    rule expr-qualified-path:sym<c> {
        <SHL> <ty-sum> <maybe-as-trait-ref> '>' <MOD-SEP> <ident> <generic-args> <maybe-as-trait-ref> '>' <MOD-SEP> <ident>
    }

    rule expr-qualified-path:sym<d> {
        <SHL> <ty-sum> <maybe-as-trait-ref> '>' <MOD-SEP> <ident> <maybe-as-trait-ref> '>' <MOD-SEP> <ident> <generic-args>
    }

    rule expr-qualified-path:sym<e> {
        <SHL> <ty-sum> <maybe-as-trait-ref> '>' <MOD-SEP> <ident> <generic-args> <maybe-as-trait-ref> '>' <MOD-SEP> <ident> <generic-args>
    }
}

our role ExprQualifiedPath::Actions {

    method expr-qualified-path:sym<a>($/) {
        make ExprQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
            maybe-qpath-params =>  $<maybe-qpath-params>.made,
        )
    }

    method expr-qualified-path:sym<b>($/) {
        make ExprQualifiedPath.new(
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method expr-qualified-path:sym<c>($/) {
        make ExprQualifiedPath.new(
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method expr-qualified-path:sym<d>($/) {
        make ExprQualifiedPath.new(
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
            generic-args       =>  $<generic-args>.made,
        )
    }

    method expr-qualified-path:sym<e>($/) {
        make ExprQualifiedPath.new(
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
            generic-args       =>  $<generic-args>.made,
        )
    }
}

