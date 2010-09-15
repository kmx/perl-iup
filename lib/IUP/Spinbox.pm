#!/usr/bin/env perl

package IUP::Spinbox;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIUP::_IupSpinbox($firstonly);
  }
  elsif (defined $args && defined $args->{child}) {
    $ih = IUP::Internal::LibraryIUP::_IupSpinbox($args->{child}->ihandle);
    delete $args->{child};
  }
  else {
    carp "Warning: IUP::Spinbox->new() cannot be called without params";
    $ih = IUP::Internal::LibraryIUP::_IupSpinbox(undef);
  }  
  return $ih;
}

1;
