#!/usr/bin/env perl

package IUP::ProgressBar;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  return IUP::Internal::LibraryIUP::_IupProgressBar();
  #xxx TODO xxx FGCOLOR seems to be ignored
}

1;
