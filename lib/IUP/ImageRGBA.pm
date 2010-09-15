#!/usr/bin/env perl

package IUP::ImageRGBA;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;
use Carp;

sub _create_element {
  my($self, $args) = @_;

  my $p = $args->{pixels};
  my $w = $args->{width} || 0;
  my $h = $args->{height} || 0;  
  my $size = $w * $h * 4; # 4 bytes per pixel
  my $ih;

  if ($size == 0) {
    carp "Warning: zero or undefined image size (check 'width' and 'height')";
  }
  elsif (defined $p) {
    $p = pack('C*', @$p) if ref($p) eq 'ARRAY';
    my $l = length($p);
    if ($l == $size) {
      $ih = IUP::Internal::LibraryIUP::_IupImageRGBA($w, $h, $p);
    }
    else {
      carp "Warning: invalid image data size: $l, expected: $size";
    }    
  }
  else {
    carp "Warning: no image data (check 'pixels')";
  }
  
  delete $args->{pixels};
  delete $args->{width};
  delete $args->{height};

  return $ih;
}

1;
