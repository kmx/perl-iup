#!/usr/bin/env perl

package IUP::Submenu;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my ($t, $m);
  if (defined $args) {
    $t = $args->{TITLE};
    $m = $args->{menu}->ihandle if defined $args->{menu};
    delete $args->{TITLE};
    delete $args->{menu};
  }
  my $ih = IUP::Internal::LibraryIUP::_IupSubmenu($t, $m);
  return $ih;
}

1;
