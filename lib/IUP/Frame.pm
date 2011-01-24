package IUP::Frame;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    if (ref($firstonly) && $firstonly->can('ihandle')) {
      $ih = IUP::Internal::LibraryIup::_IupFrame($firstonly->ihandle);
    }
    else {
      $ih = IUP::Internal::LibraryIup::_IupFrame(undef);
      carp "Warning: parameter of IUP::Frame has to be a reference to IUP element";
    }
  }
  elsif (defined $args && defined $args->{child}) {
    if (ref($args->{child}) && $args->{child}->can('ihandle')) {
      $ih = IUP::Internal::LibraryIup::_IupFrame($args->{child}->ihandle);
    }
    else {
      carp "Warning: 'child' parameter of IUP::Frame has to be a reference to IUP element";
      $ih = IUP::Internal::LibraryIup::_IupFrame(undef);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIup::_IupFrame(undef);
  }  
  return $ih;
}

1;
