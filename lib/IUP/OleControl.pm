package IUP::OleControl;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub BEGIN {
  #warn "[DEBUG] IUP::OleControl::BEGIN() started\n";
  #IUP::Internal::LibraryIup::_IupOleControlOpen();
}

# xxx TODO somehow handle that it is Windows specific
# xxx TODO check integration with Win32::OLE

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  #my $ih = IUP::Internal::LibraryIup::_IupOleControl($args->{ProgID}); # xxx TODO fix '0'
  #return $ih;
  return;
}

1;
