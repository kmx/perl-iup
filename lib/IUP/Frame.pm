#!/usr/bin/env perl

package IUP::Frame;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIUP::_IupFrame($firstonly);
  }
  elsif (defined $args && defined $args->{child}) {
    $ih = IUP::Internal::LibraryIUP::_IupFrame($args->{child}->ihandle);
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIUP::_IupFrame(undef);
  }  
  return $ih;
}

1;
