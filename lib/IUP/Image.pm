#!/usr/bin/env perl

package IUP::Image;
use strict;
use warnings;
use base 'IUP::Internal::Element::Image';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my($self, $args) = @_;

  my %type2bytes_per_pix = (  MAP => 1, RGB => 3, RGBA => 4 );
  
  # xxx todo: decide whether type=>'RGB' or bpp=>24 or BPP=>24 ?
  #my %bpp2bytes_per_pix = ( 8 => 1, 24 => 3, 32 => 4 ); 

  my $bytes_per_pix;
  my $p = $args->{pixels};
  my $c = $args->{colors};
  my $f = $args->{file};
  my $t = $args->{type};  
  my $w = $args->{WIDTH} || 0;
  my $h = $args->{HEIGHT} || 0;      
  my $data = '';
  my $ih;  
  
  if (defined $t) {
    $bytes_per_pix = $type2bytes_per_pix{$t};
    carp "Warning: 'type' parameter - invalid/unexpected value '$t'" unless $bytes_per_pix;
  }

  if ($f) {
    # load image from file
    $ih = IUP::Internal::LibraryIup::_IupLoadImage($f);
    carp "Warning: file '$f' cannot be loaded!" unless $ih;    
    carp "Warning: ignoring parameter 'pixels' when using parameter 'file'" if $p;
    carp "Warning: ignoring parameter 'colors' when using parameter 'file'" if $c;
    carp "Warning: ignoring parameter 'type' when using parameter 'file'" if $t;
    carp "Warning: ignoring parameter 'WIDTH' when using parameter 'file'" if $w;
    carp "Warning: ignoring parameter 'HEIGHT' when using parameter 'file'" if $h;
  }
  elsif (defined $p) {    
    if (ref($p) eq 'ARRAY' && ref($p->[0]) eq 'ARRAY') {
      # ref to array of array refs (2-dims)
      $h = scalar(@$p);  
      $w = scalar(@{$p->[0]});
      my $error_shown;
      for (@$p) {
        if ($w != scalar @$_ && !$error_shown) {
	  carp "Warning: 'pixels' parameter - invalid data (all lines be the same length)";
	  $error_shown++;
	}
        $data .= pack('C*', @$_) if ref($_) eq 'ARRAY';
      }
    }
    elsif (ref($p) eq 'ARRAY') {
      # ref to array (1-dim)
      $data = pack('C*', @$p) if ref($p) eq 'ARRAY';      
    }
    else {
      # assume $p is as a raw image data buffer
      $data = $p;
    }
    
    my $l = length($data);    
    my $pixels = $w * $h;
    if (!$bytes_per_pix) {
      # bpp detection if image type not given
      if (0 == $pixels) {
        $bytes_per_pix = 0; # we will warn later
      }
      elsif ($l == $pixels) {
        $bytes_per_pix = 1;
      }
      elsif ($l == $pixels * 3) {
        $bytes_per_pix = 3;
      }
      elsif ($l == $pixels * 4) {
        $bytes_per_pix = 4 
      }
    }
    my $size = $pixels * $bytes_per_pix;
    
    if ($size == 0) {
      carp "Warning: zero or undefined image size (check 'WIDTH' and 'HEIGHT')";
    }
    else {      
      if ($l == $size) {
        if ($bytes_per_pix == 4) {
          $ih = IUP::Internal::LibraryIup::_IupImageRGBA($w, $h, $data);
	}
	elsif ($bytes_per_pix == 3) {
          $ih = IUP::Internal::LibraryIup::_IupImageRGB($w, $h, $data);
	}
	else {
          $ih = IUP::Internal::LibraryIup::_IupImage($w, $h, $data);
	}
      }
      else {
        carp "Warning: invalid image data size: $l, expected: $size";
      }
    } 
  }
  else {
    carp "Warning: no or invalid image data";
  }
    
  # we need this before calling SetAttribute
  $self->ihandle($ih);
  
  # handle colors
  if (defined $c && !defined $f) {
    if ($bytes_per_pix == 1) {    
      my $i = 0;
      $self->SetAttribute($i++, $_) for (@$c);
    }
    else {
      carp "Warning: ignoring parameter 'colors' by image types RGB and RGBA" if $c;
    }
  }
  
  delete $args->{pixels};
  delete $args->{colors};
  delete $args->{file};
  delete $args->{type};
  delete $args->{WIDTH};
  delete $args->{HEIGHT};

  return $ih;
}

1;
