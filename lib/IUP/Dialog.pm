#!/usr/bin/env perl

package IUP::Dialog;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my $c = defined $args->{child} ? $args->{child}->ihandle : undef;  
  my $ih = IUP::Internal::LibraryIUP::_IupDialog($c);    
  delete $args->{child};
  return $ih;
}

sub ShowXY {
  my ($self, $x, $y) = @_;
  return IUP::Internal::LibraryIUP::_IupShowXY($self->ihandle, $x, $y);
}

1;
