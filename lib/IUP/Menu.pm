package IUP::Menu;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
use Carp;

sub _create_element {
  my ($self, $args, $firstonly) = @_;
  my $ih;
  if (defined $firstonly) {
    if (ref($firstonly) eq 'ARRAY') {
      $ih = IUP::Internal::LibraryIup::_IupMenu( map($_->ihandle, @$firstonly) );
    }
    else {
      $ih = IUP::Internal::LibraryIup::_IupMenu($firstonly);
    }
  }
  elsif (defined $args && defined $args->{child}) {
    if (ref($args->{child}) eq 'ARRAY') {
      my @list = map ($_->ihandle, @{$args->{child}});
      $ih = IUP::Internal::LibraryIup::_IupMenu(@list);
    }
    else {
      $ih = IUP::Internal::LibraryIup::_IupMenu($args->{child}->ihandle);
    }
    delete $args->{child};
  }
  else {
    $ih = IUP::Internal::LibraryIup::_IupMenu();
  }
  return $ih;
}

1;
