#!/usr/bin/env perl

package IUP::Split;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my ($self, $args) = @_;  # xxx TODO two ref args (maybe)
  my ($c1, $c2);
  if (defined $args) {
    $c1 = $args->{child1}->ihandle if defined $args->{child1};
    $c2 = $args->{child2}->ihandle if defined $args->{child2};
    delete $args->{child1};
    delete $args->{child2};
  }
  my $ih = IUP::Internal::LibraryIUP::_IupSplit($c1, $c2);
  return $ih;
}

1;
