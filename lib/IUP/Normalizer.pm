#!/usr/bin/env perl

package IUP::Normalizer;
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
      $ih = IUP::Internal::LibraryIUP::_IupNormalizer( map($_->ihandle, @$firstonly) );
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupNormalizer($firstonly);
    }
  }
  elsif (defined $args && defined $args->{child}) {
    if (ref($args->{child}) eq 'ARRAY') {
      my @list = map ($_->ihandle, @{$args->{child}});
      $ih = IUP::Internal::LibraryIUP::_IupNormalizer(@list);
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupNormalizer($args->{child}->ihandle);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIUP::_IupNormalizer();
  }
  return $ih;
}

1;
