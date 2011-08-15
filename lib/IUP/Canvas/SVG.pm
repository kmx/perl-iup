package IUP::Canvas::SVG;
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
  elsif (defined $width && $width<0) {
    carp "warning: width parameter is '<=0' for ".__PACKAGE__."->new()";
  }
  elsif (defined $height && $height<0) {
    carp "warning: height parameter is '<=0' for ".__PACKAGE__."->new()";
  }
  elsif ((defined $width && !defined $height) || (!defined $width && defined $height)) {
    carp "warning: none or both height and width parameters have to be defined for ".__PACKAGE__."->new()";
  }
  elsif (defined $resolution && $resolution<0) {
    carp "warning: resolution parameter is '<=0' for ".__PACKAGE__."->new()";
  }
  else {
    my $init = $filename;
    $init .= sprintf ' %.3fx%.3f', $width, $height if defined $width && defined $height;
    $init .= sprintf ' %.3f', $resolution if defined $resolution;
    #warn "DEBUG init='$init'\n";
    $ch = $self->new_from_cnvhandle(IUP::Internal::Canvas::_cdCreateCanvas_BASIC("SVG", $init));
  }
  return $ch;
}

1;
