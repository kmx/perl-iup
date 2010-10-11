#!/usr/bin/env perl

package IUP::Submenu;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my($self, $args, $firstonly) = @_;
  my ($t, $m);
  if (defined $args) {

    $t = $args->{TITLE};
    delete $args->{TITLE};

    if (defined $args->{child}) { # xxx TODO xxx maybe handle $firstonly at this point (in fact it does not make much sense)
      $m = $args->{child}->ihandle;
      delete $args->{child};
    }

    if (defined $args->{menu}) {
      $m = $args->{menu}->ihandle; # xxx TODO xxx remove this line in the end
      delete $args->{menu};
      carp "Warning: parameter 'menu' of IUP::Submenu->new() is not supported, use 'child' instead";
    }
  }
  my $ih = IUP::Internal::LibraryIup::_IupSubmenu($t, $m);
  return $ih;
}

1;
