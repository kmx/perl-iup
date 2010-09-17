#!/usr/bin/env perl

package IUP::List;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

sub _create_element {
  my($self, $args) = @_;
  return IUP::Internal::LibraryIUP::_IupList(0); # xxx TODO fix '0'
  
  # xxx TODO load items form new params, maybe items=>[x,y,z] 
  
}

1;
