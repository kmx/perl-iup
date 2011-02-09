package IUP::Dialog;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Scalar::Util 'blessed';
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $c = $args->{child};
  my $ih;
  if (defined($c) && blessed($c) && $c->can('ihandle')) {
    $ih = IUP::Internal::LibraryIup::_IupDialog($c->ihandle);
    $self->_store_child_ref($c); #xxx-just-idea
  }
  else {
    carp "Warning: parameter 'child' has to be a reference to IUP element";
  }
  
  delete $args->{child};
  return $ih;
}

1;
