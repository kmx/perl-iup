#!/usr/bin/env perl

package IUP::Toggle;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my ($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupToggle($args->{TITLE}, 0); # xxx TODO fix '0'
  delete $args->{TITLE};
  return $ih;
}

1;
