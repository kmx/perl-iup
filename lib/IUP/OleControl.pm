package IUP::OleControl;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub BEGIN {
  IUP::Internal::LibraryIup::_IupOleControlOpen();
}

#xxxFIXME we need some integration with Win32::OLE

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIup::_IupOleControl($firstonly);
  }
  elsif (defined $args->{progid}) {
    $ih = IUP::Internal::LibraryIup::_IupOleControl($args->{progid});
  }
  else {
    carp "Warning: missing parameter 'progid'";
  }
  return $ih;
}

1;
