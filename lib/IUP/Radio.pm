#!/usr/bin/env perl

package IUP::Radio;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIup::_IupRadio($firstonly);
  }
  elsif (defined $args && defined $args->{child}) {
    $ih = IUP::Internal::LibraryIup::_IupRadio($args->{child}->ihandle);
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIup::_IupRadio(undef);
  }  
  return $ih;
}

1;
