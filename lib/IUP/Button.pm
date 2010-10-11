#!/usr/bin/env perl

package IUP::Button;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my ($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupButton($args->{TITLE}, 0); # xxx TODO fix '0'
  delete $args->{TITLE};
  return $ih;
}

1;
