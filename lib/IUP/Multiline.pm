#!/usr/bin/env perl

package IUP::MultiLine;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  return IUP::Internal::LibraryIUP::_IupMultiLine(0); # xxx TODO fix '0'
}

1;
