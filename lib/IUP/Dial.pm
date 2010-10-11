#!/usr/bin/env perl

package IUP::Dial;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupDial($args->{TYPE});
  delete $args->{TYPE};
  return $ih;
}

1;
