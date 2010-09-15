#!/usr/bin/env perl

package IUP::OleControl;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIUP;

# xxx TODO somehow handle that it is Windows specific
# xxx TODO check integration with Win32::OLE

sub _create_element {
  my($self, $args) = @_;
  #my $ih = IUP::Internal::LibraryIUP::_IupOleControl($args->{ProgID}); # xxx TODO fix '0'
  #return $ih;
  return;
}

1;
