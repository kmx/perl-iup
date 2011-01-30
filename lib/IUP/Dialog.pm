package IUP::Dialog;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $c = defined $args->{child} ? $args->{child}->ihandle : undef;  
  my $ih = IUP::Internal::LibraryIup::_IupDialog($c);    
  delete $args->{child};
  return $ih;
}

sub ShowXY {
  my ($self, $x, $y) = @_;
  return IUP::Internal::LibraryIup::_IupShowXY($self->ihandle, $x, $y);
}

1;
