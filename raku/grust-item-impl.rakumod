use grust-model;

our role ItemImpl::Rules {

    #---------------------------
    proto rule item-impl { * }

    rule item-impl:sym<a> {
        <maybe-default-maybe-unsafe> 
        <IMPL> 
        <generic-params> 
        <ty-prim-sum> 
        <maybe-where-clause> 
        '{' 
        <maybe-inner-attrs> 
        <maybe-impl-items> 
        '}'
    }

    rule item-impl:sym<b> {
        <maybe-default-maybe-unsafe> 
        <IMPL> 
        <generic-params> 
        '(' <ty> ')' 
        <maybe-where-clause> 
        '{' <maybe-inner-attrs> <maybe-impl-items> '}'
    }

    rule item-impl:sym<c> {
        <maybe-default-maybe-unsafe> 
        <IMPL> 
        <generic-params> 
        <trait-ref> 
        <FOR> 
        <ty-sum> 
        <maybe-where-clause> 
        '{' <maybe-inner-attrs> <maybe-impl-items> '}'
    }

    rule item-impl:sym<d> {
        <maybe-default-maybe-unsafe> 
        <IMPL> <generic-params> '!' 
        <trait-ref> 
        <FOR> 
        <ty-sum> 
        <maybe-where-clause> 
        '{' <maybe-inner-attrs> <maybe-impl-items> '}'
    }

    rule item-impl:sym<e> {
        <maybe-default-maybe-unsafe> 
        <IMPL> 
        <generic-params> 
        <trait-ref> 
        <FOR> 
        <DOTDOT> 
        '{' '}'
    }

    rule item-impl:sym<f> {
        <maybe-default-maybe-unsafe> 
        <IMPL> 
        <generic-params> 
        '!' 
        <trait-ref> 
        <FOR> 
        <DOTDOT> 
        '{' '}'
    }

    #---------------------------
    rule maybe-impl-items {
        <impl-items>?
    }

    #---------------------------
    rule impl-items {
        <impl-item>+
    }

    #---------------------------
    proto rule impl-item { * }

    rule impl-item:sym<a> {
        <impl-method>
    }

    rule impl-item:sym<b> {
        <attrs-and-vis> 
        <item-macro>
    }

    rule impl-item:sym<c> {
        <impl-const>
    }

    rule impl-item:sym<d> {
        <impl-type>
    }
}

our role ItemImpl::Actions {

    method item-impl:sym<a>($/) {
        make ItemImpl.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty-prim-sum                =>  $<ty-prim-sum>.made,
            maybe-where-clause         =>  $<maybe-where-clause>.made,
            maybe-inner-attrs          =>  $<maybe-inner-attrs>.made,
            maybe-impl-items           =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<b>($/) {
        make ItemImpl.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty                         =>  $<ty>.made,
            maybe-where-clause         =>  $<maybe-where-clause>.made,
            maybe-inner-attrs          =>  $<maybe-inner-attrs>.made,
            maybe-impl-items           =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<c>($/) {
        make ItemImpl.new(
            generic-params     =>  $<generic-params>.made,
            trait-ref          =>  $<trait-ref>.made,
            ty-sum             =>  $<ty-sum>.made,
            maybe-where-clause =>  $<maybe-where-clause>.made,
            maybe-inner-attrs  =>  $<maybe-inner-attrs>.made,
            maybe-impl-items   =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<d>($/) {
        make ItemImplNeg.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
            ty-sum                     =>  $<ty-sum>.made,
            maybe-where-clause         =>  $<maybe-where-clause>.made,
            maybe-inner-attrs          =>  $<maybe-inner-attrs>.made,
            maybe-impl-items           =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<e>($/) {
        make ItemImplDefault.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }

    method item-impl:sym<f>($/) {
        make ItemImplDefaultNeg.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }

    method maybe-impl-items:sym<a>($/) {
        make $<impl-items>.made
    }

    #---------------------
    method impl-items($/) {
        make $<impl-item>>>.made
    }

    method impl-item:sym<a>($/) {
        make $<impl-method>.made
    }

    method impl-item:sym<b>($/) {
        make ImplMacroItem.new(
            attrs-and-vis =>  $<attrs-and-vis>.made,
            item-macro    =>  $<item-macro>.made,
        )
    }

    method impl-item:sym<c>($/) {
        make $<impl-const>.made
    }

    method impl-item:sym<d>($/) {
        make $<impl-type>.made
    }
}
