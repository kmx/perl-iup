package IUP::Canvas::EMF;
use strict;
use warnings;
use base qw(IUP::Internal::Canvas);
use IUP::Internal::LibraryIup;
use Carp;

sub new {
  my ($self, %args) = @_;
  my $filename = $args{filename};
  my $width = $args{width};
  my $height = $args{height};
  my $resolution = $args{resolution};
  
  my $ch;
  if (!$filename) {
    carp "warning: filename parameter not defined for ".__PACKAGE__."->new()";
  }
  elsif (!defined $width || $width<0) {
    carp "warning: width parameter not defined or is '<=0' for ".__PACKAGE__."->new()";
  }
  elsif (!defined $height || $height<0) {
    carp "warning: height parameter not defined or is '<=0' for ".__PACKAGE__."->new()";
  }
  else {
    my $init = $filename;
    $init .= ' '.int($width).'x'.int($height) if defined $width && defined $height;
    #warn "DEBUG init='$init'\n";
    $ch = $self->new_from_cnvhandle(IUP::Internal::Canvas::_cdCreateCanvas_FILE("EMF", $init));
  }
  return $ch;
}

1;
