#!/usr/bin/env perl

package IUP::User;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  return IUP::Internal::LibraryIUP::_IupUser();
}

1;
