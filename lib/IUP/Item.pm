#!/usr/bin/env perl

package IUP::Item;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my ($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupItem($args->{TITLE}, 0); # xxx TODO fix '0'
  delete $args->{TITLE};
  return $ih;
}

1;
