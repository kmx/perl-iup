package IUP::Internal::LibraryIup;

@ISA = qw/ DynaLoader /;
require DynaLoader;

use Scalar::Util 'weaken';

bootstrap IUP::Internal::LibraryIup;

#xxxTODO: maybe something more thread safe
our %ih_register; #global table mapping IUP Ihandles to perl objrefs
our %ch_register; #global table mapping CD Canvas handles to perl objrefs

#xxxCHECKLATER: for performance reasons we access directly these global variables from _execute_cb()

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
    #BEWARE: circular references may happen XXX-FIXME
    #weaken $ih_register{$_[0]}; #xxx-just-idea
    $ih_register{$_[0]};
  }
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
    #BEWARE: circular references may happen XXX-FIXME
    #weaken $ch_register{$_[0]}; #xxx-just-idea
    $ch_register{$_[0]};
  }
}

1;

__END__

=head1 NAME

IUP::Internal::LibraryIup - [internal only] DO NOT USE this unless you know what could happen!

=cut