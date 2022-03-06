use Data::Dump::Tree;

our class Lifetime {
    has $.maybe-ltbounds;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StaticLifetime { 

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role Lifetimes::Rules {

    rule maybe-lifetimes { [<lifetimes> ','?]? }

    rule lifetimes {
        <lifetime-and-bounds>+ %% ","
    }

    #---------------------
    proto rule lifetime-and-bounds { * }
    rule lifetime-and-bounds:sym<a> { <lifetime> <maybe-ltbounds> }
    rule lifetime-and-bounds:sym<b> { <static-lifetime> }

    proto rule lifetime { * }
    rule lifetime:sym<a> { <kw-lifetime> }
    rule lifetime:sym<b> { <static-lifetime> }

    token static-lifetime { '\'static' }

    token kw-lifetime { 
        || '\'' <ident>
        || '\'' <kw-self>
    }
}

our role Lifetimes::Actions {

    method maybe-lifetimes($/) {
        make $<lifetimes>.made
    }

    method lifetimes($/) {
        make $<lifetime-and-bounds>>>.made
    }

    method lifetime-and-bounds:sym<a>($/) {
        make Lifetime.new(
            maybe-ltbounds => $<maybe-ltbounds>.made,
            text           => ~$/,
        )
    }

    method lifetime-and-bounds:sym<b>($/) {
        make StaticLifetime.new
    }

    #------------------
    method lifetime:sym<a>($/) { 
        make Lifetime.new(
            text           => ~$/,
        )
    }

    method lifetime:sym<b>($/) { 
        make StaticLifetime.new(
            text           => ~$/,
        )
    }
}
