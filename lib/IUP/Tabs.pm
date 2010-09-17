#!/usr/bin/env perl

package IUP::Tabs;
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
      $ih = IUP::Internal::LibraryIUP::_IupTabs( map($_->ihandle, @$firstonly) );
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupTabs($firstonly);
    }
  }
  elsif (defined $args && defined $args->{child}) {
    if (ref($args->{child}) eq 'ARRAY') {
      my @list = map ($_->ihandle, @{$args->{child}});
      $ih = IUP::Internal::LibraryIUP::_IupTabs(@list);
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupTabs($args->{child}->ihandle);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIUP::_IupTabs();
  }
  return $ih;
}

1;
