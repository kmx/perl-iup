package IUP::Cbox;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    if (ref($firstonly) eq 'ARRAY') {
      $ih = IUP::Internal::LibraryIup::_IupCbox( map($_->ihandle, @$firstonly) );
    }
    else {
      $ih = IUP::Internal::LibraryIup::_IupCbox($firstonly);
    }
  }
  elsif (defined $args && defined $args->{child}) {
    if (ref($args->{child}) eq 'ARRAY') {
      my @list = map ($_->ihandle, @{$args->{child}});
      $ih = IUP::Internal::LibraryIup::_IupCbox(@list);
    }
    else {
      $ih = IUP::Internal::LibraryIup::_IupCbox($args->{child}->ihandle);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIup::_IupCbox();
  }
  return $ih;
}

1;
