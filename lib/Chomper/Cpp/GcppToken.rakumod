unit module Chomper::Cpp::GcppToken;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package Not is export {

    our class Bang does INot { 

        has $.text;

        method gist(:$treemark=False) { 
            "!"
        }
    }

    our class Not does INot { 

        has $.text;

        method gist(:$treemark=False) { 
            "!"
        }
    }
}

package AndAnd is export {

    our class AndAnd does IAndAnd { 

        has $.text;

        method gist(:$treemark=False) {
            "&&"
        }
    }

    our class And does IAndAnd { 

        has $.text;

        method gist(:$treemark=False) {
            "&"
        }
    }
}

package OrOr is export {

    our class PipePipe does IOrOr { 

        has $.text;

        method gist(:$treemark=False) {
            "||"
        }
    }

    our class Or does IOrOr { 

        has $.text;

        method gist(:$treemark=False) {
            "|"
        }
    }
}

package TokenGrammar is export {

    our role Rules {

        token whitespace {
            <[   \t ]>+
        }

        token newline_ {
            [   
                ||  '\r' '\n'?
                ||  '\n'
            ]
        }
    }
}
