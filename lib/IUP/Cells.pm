#!/usr/bin/env perl

package IUP::Cells;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupCells();
  return $ih;
}

#Note:
# LIMITSL:C - does not have an accessor

1;
