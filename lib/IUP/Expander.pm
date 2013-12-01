package IUP::Expander;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my ($self, $args) = @_;
  return IUP::Internal::LibraryIup::_IupExpander($args->{child});
}

1;
