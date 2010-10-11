#!/usr/bin/env perl

package IUP::Cells;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupCells();
  return $ih;
}

#Note:
# LIMITSL:C - does not have an accessor

1;
