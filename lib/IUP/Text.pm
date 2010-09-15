#!/usr/bin/env perl

package IUP::Text;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  return IUP::Internal::LibraryIUP::_IupText(0); # xxx TODO fix '0'
}

sub TextConvertLinColToPos {
  # xxx TODO
}

sub TextConvertPosToLinCol {
  # xxx TODO
}

1;
