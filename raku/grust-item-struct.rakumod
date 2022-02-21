
our class ItemStruct {
    has $.struct_tuple_args;
    has $.struct_decl_args;
    has $.maybe_where_clause;
    has $.ident;
    has $.generic_params;
}

our class StructField {
    has $.attrs_and_vis;
    has $.ty_sum;
    has $.ident;
}

our class StructFields {
    has $.struct_decl_field;
    has $.struct_tuple_field;
}

our class ItemStruct::Rules {

    proto rule item-struct { * }

    rule item-struct:sym<a> {
        <STRUCT> <ident> <generic-params> <maybe-where_clause> <struct-decl_args>
    }

    rule item-struct:sym<b> {
        <STRUCT> <ident> <generic-params> <struct-tuple_args> <maybe-where_clause> ';'
    }

    rule item-struct:sym<c> {
        <STRUCT> <ident> <generic-params> <maybe-where_clause> ';'
    }

    proto rule struct-decl_args { * }

    rule struct-decl_args:sym<a> {
        '{' <struct-decl_fields> '}'
    }

    rule struct-decl_args:sym<b> {
        '{' <struct-decl_fields> ',' '}'
    }

    proto rule struct-tuple_args { * }

    rule struct-tuple_args:sym<a> {
        '(' <struct-tuple_fields> ')'
    }

    rule struct-tuple_args:sym<b> {
        '(' <struct-tuple_fields> ',' ')'
    }

    proto rule struct-decl_fields { * }

    rule struct-decl_fields:sym<a> {
        <struct-decl_field>
    }

    rule struct-decl_fields:sym<b> {
        <struct-decl_fields> ',' <struct-decl_field>
    }

    rule struct-decl_fields:sym<c> {

    }

    rule struct-decl_field {
        <attrs-and_vis> <ident> ':' <ty-sum>
    }

    proto rule struct-tuple_fields { * }

    rule struct-tuple_fields:sym<a> {
        <struct-tuple_field>
    }

    rule struct-tuple_fields:sym<b> {
        <struct-tuple_fields> ',' <struct-tuple_field>
    }

    rule struct-tuple_fields:sym<c> {

    }

    rule struct-tuple_field {
        <attrs-and_vis> <ty-sum>
    }
}

our class ItemStruct::Actions {

    method item-struct:sym<a>($/) {
        make ItemStruct.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
            struct-decl_args   =>  $<struct-decl_args>.made,
        )
    }

    method item-struct:sym<b>($/) {
        make ItemStruct.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            struct-tuple_args  =>  $<struct-tuple_args>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
        )
    }

    method item-struct:sym<c>($/) {
        make ItemStruct.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
        )
    }

    method struct-decl_args:sym<a>($/) {
        make $<struct_decl_fields>.made
    }

    method struct-decl_args:sym<b>($/) {
        make $<struct_decl_fields>.made
    }

    method struct-tuple_args:sym<a>($/) {
        make $<struct_tuple_fields>.made
    }

    method struct-tuple_args:sym<b>($/) {
        make $<struct_tuple_fields>.made
    }

    method struct-decl_fields:sym<a>($/) {
        make StructFields.new(
            struct-decl_field =>  $<struct-decl_field>.made,
        )
    }

    method struct-decl_fields:sym<b>($/) {
        ExtNode<140604918384136>
    }

    method struct-decl_fields:sym<c>($/) {
        MkNone<140604948239904>
    }

    method struct-decl_field($/) {
        make StructField.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            ident         =>  $<ident>.made,
            ty-sum        =>  $<ty-sum>.made,
        )
    }

    method struct-tuple_fields:sym<a>($/) {
        make StructFields.new(
            struct-tuple_field =>  $<struct-tuple_field>.made,
        )
    }

    method struct-tuple_fields:sym<b>($/) {
        ExtNode<140604918384176>
    }

    method struct-tuple_fields:sym<c>($/) {
        MkNone<140604948239936>
    }

    method struct-tuple_field($/) {
        make StructField.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            ty-sum        =>  $<ty-sum>.made,
        )
    }
}

