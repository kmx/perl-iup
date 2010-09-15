#!/usr/bin/env perl

package IUP::Label;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupLabel($args->{TITLE});
  delete $args->{TITLE};
  return $ih;
}

1;
