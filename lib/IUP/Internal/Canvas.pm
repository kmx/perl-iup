package IUP::Internal::Canvas;

@ISA = qw/ DynaLoader /;
require DynaLoader;

bootstrap IUP::Internal::Canvas;

#TODO: maybe something more thread safe
#my %ih_register; #global table mapping IUP Ihandles to perl objrefs
#sub _translate_ih  { $ih_register{$_[0]} if $_[0] }         #params: ih
#sub _unregister_ih { delete $ih_register{$_[0]} if $_[0] }  #params: ih
#sub _register_ih   { $ih_register{$_[0]} = $_[1] if $_[0] } #params: ih, objref

#my %ch_register; #global table mapping IUP Ihandles to perl objrefs
#sub _translate_ch  { $ch_register{$_[0]} if $_[0] }         #params: ch
#sub _unregister_ch { delete $ch_register{$_[0]} if $_[0] }  #params: ch
#sub _register_ch   { $ch_register{$_[0]} = $_[1] if $_[0] } #params: ch, objref

# accessor
sub cnvhandle {
  if ($_[1]) {
    #xxx TODO IUP::Internal::LibraryIup::_register_ch($_[1], $_[0]);    
    return $_[0]->{___cnvhandle} = $_[1]    
  }
  else {
    return $_[0]->{___cnvhandle};
  }
}

#Note: all canvas related methods implemented directly in XS

1;

__END__

=head1 NAME

IUP::Internal::Canvas - [internal only] DO NOT USE this unless you know what could happen!

=cut