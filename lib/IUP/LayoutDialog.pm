package IUP::LayoutDialog;
use strict;
use warnings;
use base 'IUP::Internal::Element';

use IUP::Internal::LibraryIup;
use Scalar::Util 'blessed';
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  carp "[warning] IUP::LayoutDialog->new() expects exactly one parameter" unless $firstonly;
  if (blessed($firstonly) && $firstonly->can('ihandle')) {  #xxxTODO replicate this tyle to other places
    return IUP::Internal::LibraryIup::_IupLayoutDialog($firstonly->ihandle);
  }
  else {
    carp "[warning] IUP::LayoutDialog->new() parameter is not an IUP element";
    return undef;
  }
}

1;
