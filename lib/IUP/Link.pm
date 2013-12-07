package IUP::Link;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupLink($args->{URL}, $args->{TITLE});
  delete $args->{URL};
  delete $args->{ADDR};
  return $ih;
}

1;
