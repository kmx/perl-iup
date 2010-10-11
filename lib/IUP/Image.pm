#!/usr/bin/env perl

package IUP::Image;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my($self, $args) = @_;

  my $p = $args->{pixels};
  my $w = $args->{WIDTH} || 0;
  my $h = $args->{HEIGHT} || 0;    
  my $data = '';
  my $ih;
  
  if (defined $p && ref($p) eq 'ARRAY') {
    if (ref($p->[0]) eq 'ARRAY') {
      $h = scalar(@$p);  
      $w = scalar(@{$p->[0]});        
      for (@$p) {
        $data .= pack('C*', @$_) if ref($_) eq 'ARRAY';
      }
    }
    else {
      $data = pack('C*', @$p) if ref($p) eq 'ARRAY';
    }
    
    my $size = $w * $h; # 1 byte per pixel
    
    if ($size == 0) {
      carp "Warning: zero or undefined image size (check 'width' and 'height')";
    }
    else {
      my $l = length($data);
      if ($l == $size) {
        $ih = IUP::Internal::LibraryIup::_IupImage($w, $h, $data);
      }
      else {
        carp "Warning: invalid image data size: $l, expected: $size";
      }
    } 
  }
  else {
    carp "Warning: no image data";
  }
  
  
  $self->ihandle($ih); # xxx TODO do by all elements
  
  # xxx TODO some more ifs
  my $c = $args->{colors};
  my $i = 0;
  $self->SetAttribute($i++, $_) for (@$c);
  
  delete $args->{pixels};
  delete $args->{WIDTH};
  delete $args->{HEIGHT};
  delete $args->{colors};

  return $ih;
}

1;
