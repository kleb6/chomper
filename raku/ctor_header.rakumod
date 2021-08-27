use util;
use typemap;
use type-info;

#use Grammar::Tracer;

#config
my $strip-hungarian                      = True;
my $store-properly-formatted-struct-name = True;
my $map-hungarian-to-non                 = True;

grammar HungarianStruct {

    rule TOP {
        <.ws> <hungarian-ident>
    }

    token hungarian-ident {
        <hungarian-prefix> <camel-case-ident>
    }

   token hungarian-prefix {
        | 'S'
        | 'C'
        | 'E'
        | 'T'
    }

    token camel-case-ident {
        <camel-case-segment>+
    }

    token camel-case-segment {
        <[A..Z]> <[a..z]>*
    }
}

our sub get-generic-type($submatch, :$write-default ) {

    my $type = $submatch<type>.Str;

    my $h = HungarianStruct.parse($type);

    if $h && $strip-hungarian {

        my $non-hungarian = $h<hungarian-ident><camel-case-ident>.Str;

        if $map-hungarian-to-non {
            spurt "/Users/kleb/bethesda/work/repo/translator/raku/text-typemap.txt", "$type $non-hungarian\n", :append;
        }

        if $store-properly-formatted-struct-name {
            spurt "/Users/kleb/bethesda/work/repo/translator/raku/whitelist.txt", "$non-hungarian\n", :append;
        }

        $type     = $non-hungarian;
    }

    if $submatch<template-prefix>:exists {
        my $rtemplate-args 
        = get-rtemplate-args-list(
            $submatch<template-prefix>, 
            :$write-default
        );
        $type = $type ~ '<' ~ $rtemplate-args.join(",") ~ '>';
    }
    $type
}

our sub translate-ctor-header( $submatch, $body, $rclass) 
{
    my $maybe-generic-type = 
    get-generic-type($submatch, write-default => True );

    my $maybe-generic-type-nodefault = 
    get-generic-type($submatch, write-default => False );

    my $directive  = $submatch<use-operator-context-functions> // "";
    my $directive2 = $submatch<use-dispatch-helper> // "";

    if $directive  { $directive = "//{$directive.Str}"; }
    if $directive2 { $directive2 = "//{$directive2.Str}"; }

    my @bases;

    if $submatch<class-inheritance>:exists {
        my $idx = 1;
        for $submatch<class-inheritance><type>.List {
            my $rtype = populate-typeinfo($_).vectorized-rtype;
            @bases.push: "base{$idx gt 1 ?? $idx !! ''}: {$rtype.Str}," ;
            $idx += 1;
        }
    }

    my $struct-body = qq:to/END/.chomp.trim;
    $directive
    $directive2
    {@bases.join("\n")}
    END

    qq:to/END/
    pub struct $maybe-generic-type \{
    {$struct-body.indent(4)}
    \}
    impl $maybe-generic-type-nodefault \{

    \}
    END

}

