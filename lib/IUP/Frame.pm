#!/usr/bin/env perl

package IUP::Frame;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    my $r = ref($firstonly);
    if ($r && ($r =~ /^IUP::/)) {
      $ih = IUP::Internal::LibraryIUP::_IupFrame($firstonly->ihandle);
    }
    else {
      $ih = IUP::Internal::LibraryIUP::_IupFrame(undef);
      carp "Warning: parameter of IUP::Frame has to be a reference to IUP element"; # xxx TODO maybe duplicate this style to other places
    }
  }
  elsif (defined $args && defined $args->{child}) {
    my $r = ref($args->{child});
    if ($r && ($r =~ /^IUP::/)) {
      $ih = IUP::Internal::LibraryIUP::_IupFrame($args->{child}->ihandle);
    }
    else {
      carp "Warning: 'child' parameter of IUP::Frame has to be a reference to IUP element"; # xxx TODO maybe duplicate this style to other places
      $ih = IUP::Internal::LibraryIUP::_IupFrame(undef);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIUP::_IupFrame(undef);
  }  
  return $ih;
}

1;
