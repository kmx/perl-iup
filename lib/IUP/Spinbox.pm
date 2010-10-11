#!/usr/bin/env perl

package IUP::Spinbox;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIup::_IupSpinbox($firstonly);
  }
  elsif (defined $args && defined $args->{child}) {
    $ih = IUP::Internal::LibraryIup::_IupSpinbox($args->{child}->ihandle);
    delete $args->{child};
  }
  else {
    carp "Warning: IUP::Spinbox->new() cannot be called without params";
    $ih = IUP::Internal::LibraryIup::_IupSpinbox(undef);
  }  
  return $ih;
}

1;
