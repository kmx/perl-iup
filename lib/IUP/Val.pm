package IUP::Val;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIup::_IupVal($args->{type});
  }
  elsif (defined $args && defined $args->{type}) {
    $ih = IUP::Internal::LibraryIup::_IupVal($args->{type});
    delete $args->{type};
  }
  else {
    $ih = IUP::Internal::LibraryIup::_IupVal(undef);
  }
  return $ih;
}

1;
