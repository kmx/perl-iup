#!/usr/bin/env perl

package IUP::ColorBrowser;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupColorBrowser(); # xxx TODO not in XS yet
  return $ih;
  warn "xxx TODO not in XS yet!";
  return undef;
}

1;
