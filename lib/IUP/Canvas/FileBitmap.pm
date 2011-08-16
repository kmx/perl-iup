package IUP::Canvas::FileBitmap;
use strict;
use warnings;
use base qw(IUP::Internal::Canvas);
use IUP::Internal::LibraryIup;
use Carp;

sub new {
  my ($self, %args) = @_;
  my $width = $args{width};
  my $height = $args{height};
  my $has_alpha = $args{has_alpha};
  my $bitmap = $args{bitmap};  
  my $res = $args{resolution};
  
  my $ch;
  if (defined $width && $width<0) {
    carp "Error: width parameter not defined or is '<=0' for ".__PACKAGE__."->new()";
  }
  elsif (defined $height && $height<0) {
    carp "Error: height parameter not defined or is '<=0' for ".__PACKAGE__."->new()";
  }
  elsif (defined $bitmap && (defined $width || defined $height || defined $has_alpha)) {
    carp "Error: 'bitmap' param cannot be used together with 'width', 'height', 'has_alpha' in ".__PACKAGE__."->new()";
  }
  elsif (defined $bitmap) {
    # we accept IUP::Canvas::Bitmap reference as well as filename
    $res = 0 unless defined $res;    
    my $bmp = ref($bitmap) eq 'IUP::Canvas::Bitmap' ? $bitmap : IUP::Canvas::Bitmap->new($bitmap);
    $ch = $self->new_from_cnvhandle(IUP::Internal::Canvas::_cdCreateCanvas_IMAGERGB_from_bitmap($bmp,$res)) if $bmp;
  }
  elsif (defined $width && defined $height) {
    $res = 0 unless defined $res;
    $has_alpha = 0 unless defined $has_alpha;
    $ch = $self->new_from_cnvhandle(IUP::Internal::Canvas::_cdCreateCanvas_IMAGERGB_empty($width,$height,$has_alpha,$res));
  }
  else {
    carp "Error: invalid parameters for ".__PACKAGE__."->new()";
  }
  
  return $ch;
}

1;
