#!/usr/bin/env perl

package IUP::List;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIUP::_IupList(0); # xxx TODO fix '0'
  
  # xxx TODO load items form new params, maybe items=>[x,y,z] 
  
  if (defined $ih) {
    $self->ihandle($ih); # xxx TODO do by all elements
  
    # xxx TODO some more ifs
    my $c = $args->{items};
    my $i = 0;
    $self->SetAttribute($i++, $_) for (@$c);  
    delete $args->{items};
  }
  
  return $ih;

  
}

1;
