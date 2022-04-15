use Chomper::TranslateIo;
use Chomper::TranslatePython;
use Chomper::TranslateCpp;

our sub translate-cpp-to-rust($ir) {
    translate-ir(
        $ir, 
        TranslationSource::<LangCpp>, 
        TranslationTarget::<LangRust>)
}

our sub translate-ir(
    $ir, 
    TranslationSource $src,
    TranslationTarget $dst)
{
    debug "will translate from $src to $dst";

    given ($src,$dst) {
        when (TranslationSource::<LangCpp>,TranslationTarget::<LangRust>) {
            for $ir.List {
                say translate-cpp-ir-to-rust($_.WHAT.^name, $_);
            }
        }
        when (TranslationSource::<LangPython>,TranslationTarget::<LangRust>) {
            for $ir.List {
                say translate-python-ir-to-rust($_.WHAT.^name, $_);
            }
        }
        default {
            die "unsupported translation pathway!"
        }
    }
}
