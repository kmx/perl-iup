#!/usr/bin/env perl

package IUP::Zbox;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    if (ref($firstonly) eq 'ARRAY') {
      $ih = IUP::Internal::LibraryIUP::_IupZbox(@$firstonly);
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupZbox($firstonly);
    }
  }
  elsif (defined $args && defined $args->{child}) {
    if (ref($args->{child}) eq 'ARRAY') {
      my @list = map ($_->ihandle, @{$args->{child}});
      $ih = IUP::Internal::LibraryIUP::_IupZbox(@list);
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupZbox($args->{child}->ihandle);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIUP::_IupZbox();
  }
  return $ih;
}

1;
