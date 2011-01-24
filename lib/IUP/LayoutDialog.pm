package IUP::LayoutDialog;
use strict;
use warnings;
use base 'IUP::Internal::Element::Dialog';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  carp "[warning] IUP::LayoutDialog->new() expects exactly one parameter" unless $firstonly;
  if (ref($firstonly) && $firstonly->can('ihandle')) {  
    return IUP::Internal::LibraryIup::_IupLayoutDialog($dialog->ihandle);
  }
  else {
    carp "[warning] IUP::LayoutDialog->new() parameter is not an IUP element";
  }
}

1;
