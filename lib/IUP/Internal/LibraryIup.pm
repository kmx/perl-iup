package IUP::Internal::LibraryIup;

@ISA = qw/ DynaLoader /;
require DynaLoader;

bootstrap IUP::Internal::LibraryIup;

#TODO: maybe something more thread safe
my %ih_register; #global table mapping IUP Ihandles to perl objrefs
sub _translate_ih  { $ih_register{$_[0]} if $_[0] }         #params: ih
sub _unregister_ih { delete $ih_register{$_[0]} if $_[0] }  #params: ih
sub _register_ih   { $ih_register{$_[0]} = $_[1] if $_[0] } #params: ih, objref

my %ch_register; #global table mapping IUP Ihandles to perl objrefs
sub _translate_ch  { $ch_register{$_[0]} if $_[0] }         #params: ch
sub _unregister_ch { delete $ch_register{$_[0]} if $_[0] }  #params: ch
sub _register_ch   { $ch_register{$_[0]} = $_[1] if $_[0] } #params: ch, objref


1;

__END__

=head1 NAME

IUP::Internal::LibraryIup - [internal only] DO NOT USE this unless you know what could happen!

=cut