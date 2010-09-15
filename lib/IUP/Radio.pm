#!/usr/bin/env perl

package IUP::Radio;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIUP::_IupRadio($firstonly);
  }
  elsif (defined $args && defined $args->{child}) {
    $ih = IUP::Internal::LibraryIUP::_IupRadio($args->{child}->ihandle);
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIUP::_IupRadio(undef);
  }  
  return $ih;
}

1;
