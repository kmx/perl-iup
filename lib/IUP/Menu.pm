#!/usr/bin/env perl

package IUP::Menu;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    if (ref($firstonly) eq 'ARRAY') {
      $ih = IUP::Internal::LibraryIUP::_IupMenu(@$firstonly);
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupMenu($firstonly);
    }
  }
  elsif (defined $args && defined $args->{child}) {
    if (ref($args->{child}) eq 'ARRAY') {
      my @list = map ($_->ihandle, @{$args->{child}});
      $ih = IUP::Internal::LibraryIUP::_IupMenu(@list);
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupMenu($args->{child}->ihandle);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIUP::_IupMenu();
  }
  return $ih;
}

1;
