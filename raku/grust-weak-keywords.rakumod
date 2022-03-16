use Data::Dump::Tree;

#`( These keywords have special meaning only in
certain contexts. For example, it is possible to
declare a variable or method with the name union.)
our role WeakKeywords::Rules {
    token kw-union          { union }
    token kw-staticlifetime { \'static }

    proto token weak-keyword { * }
    token weak-keyword:sym<union> { <kw-union> }
    token weak-keyword:sym<staticlt> { <kw-staticlifetime> }
}

our role WeakKeywords::Actions {}

