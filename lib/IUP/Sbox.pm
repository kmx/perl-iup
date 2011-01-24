package IUP::Sbox;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    $ih = IUP::Internal::LibraryIup::_IupSbox($firstonly);
  }
  elsif (defined $args && defined $args->{child}) {
    $ih = IUP::Internal::LibraryIup::_IupSbox($args->{child}->ihandle);
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIup::_IupSbox(undef);
  }  
  return $ih;
}

1;
