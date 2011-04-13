package IUP::Canvas;
use strict;
use warnings;
use base qw(IUP::Internal::Element IUP::Internal::Canvas);
use IUP::Internal::LibraryIup;

sub _special_initial_map_cb {
  my $self = shift;
  if (!$self->cnvhandle) {
    my $ch = IUP::Internal::Canvas::_cdCreateCanvas_CD_IUP($self->ihandle);  
    $self->cnvhandle($ch);
    $self->MAP_CB(undef); #deactivate callback    
  }
}

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupCanvas(undef);
  $self->ihandle($ih);
  my $f = \&_special_initial_map_cb;
  $self->MAP_CB($f);
  return $ih;
}

#Note: all canvas related methods are inherited from IUP::Internal::Canvas

1;
