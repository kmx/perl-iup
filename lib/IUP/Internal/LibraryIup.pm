package IUP::Internal::LibraryIup;

use strict;
use warnings;
use Scalar::Util 'weaken';

our @ISA = qw/ DynaLoader /;
require DynaLoader;
bootstrap IUP::Internal::LibraryIup;

#xxxCHECKLATER maybe something more thread safe
our %ih_register; #global table mapping IUP Ihandles to perl objrefs
our %ch_register; #global table mapping CD Canvas handles to perl objrefs
#NOTE: for performance reasons we access these global variables directly from the C callback trampolines

###IHANDLE

sub _translate_ih { 
  #params: ih
  $ih_register{$_[0]} if $_[0];
}

sub _unregister_ih {
  #params: ih
  delete $ih_register{$_[0]} if $_[0];
}

sub _register_ih {
  #params: ih, objref
  if ($_[0]) {
    $ih_register{$_[0]} = $_[1];
    #BEWARE: circular references avoided by using weaken
    weaken $ih_register{$_[0]};
    #install the internal LDESTROY_CB handler so this entry (and the wrapper) is
    #cleaned up whenever IUP destroys the element - even behind our back
    IUP::Internal::LibraryIup::_set_ldestroy_cb($_[0]); #fully-qualified (keeps xt/cross-check-xs-func.t happy)
    return $_[1]; #return the strong incoming ref, not the just-weakened registry slot
  }
  return;
}

###CANVAS HANDLE

sub _translate_ch {
  #params: ch
  $ch_register{$_[0]} if $_[0];
}

sub _unregister_ch {
  #params: ch
  delete $ch_register{$_[0]} if $_[0];
}

sub _register_ch {
  #params: ch, objref
  if ($_[0]) {
    $ch_register{$_[0]} = $_[1];
    #BEWARE: circular references avoided by using weaken
    weaken $ch_register{$_[0]};
    return $_[1]; #return the strong incoming ref, not the just-weakened registry slot
  }
  return;
}

# ithreads safety: objects that wrap a native CD/IUP resource free it in their DESTROY
# (cdKillBitmap/cdKillImage/cdKillCanvas/free). Under ithreads such an object is cloned
# into each spawned thread sharing the SAME native pointer, so the clone's DESTROY would
# free it again -> "free(): invalid pointer" / use-after-free in the parent. CLONE_SKIP=1
# makes perl set these objects to undef in child threads (their DESTROY never runs there).
# NOTE: CLONE_SKIP is NOT inherited, so every owning class (incl. subclasses) is listed.
sub IUP::Canvas::Bitmap::CLONE_SKIP              { 1 }
sub IUP::Canvas::Palette::CLONE_SKIP             { 1 }
sub IUP::Canvas::InternalServerImage::CLONE_SKIP { 1 }
sub IUP::Internal::Canvas::CLONE_SKIP            { 1 }
sub IUP::Canvas::FileBitmap::CLONE_SKIP          { 1 } # ISA IUP::Internal::Canvas (CLONE_SKIP not inherited)
sub IUP::Canvas::FileVector::CLONE_SKIP          { 1 } # ISA IUP::Internal::Canvas (CLONE_SKIP not inherited)

1;

__END__

=head1 NAME

IUP::Internal::LibraryIup - [internal only] DO NOT USE this unless you know what could happen!

=cut