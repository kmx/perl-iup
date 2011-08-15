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
  
  my $ch;
  if (!defined $width || $width<0) {
    carp "warning: width parameter not defined or is '<=0' for ".__PACKAGE__."->new()";
  }
  elsif (!defined $height || $height<0) {
    carp "warning: height parameter not defined or is '<=0' for ".__PACKAGE__."->new()";
  }
  else {  
    my $init = int($width).'x'.int($height);
    warn "DEBUG init='$init'\n";
    my $bitmap = IUP::Canvas::Bitmap->new('pant.jpg');
    #$ch = $self->new_from_cnvhandle(IUP::Internal::Canvas::_cdCreateCanvas_IMAGERGB_empty($width,$height,1,0.7));
    $ch = $self->new_from_cnvhandle(IUP::Internal::Canvas::_cdCreateCanvas_IMAGERGB_from_bitmap($bitmap,0.7));

####supported new() params
# IUP::Canvas::FileBitmap->new( bitmap=>$b );
# IUP::Canvas::FileBitmap->new( bitmap=>$b, resolution=>$r );
# IUP::Canvas::FileBitmap->new( width=>$w, height=>$h );
# IUP::Canvas::FileBitmap->new( width=>$w, height=>$h, resolution=$r, has_alpha=$a );

####available XS methods:
#_cdCreateCanvas_IMAGERGB_from_bitmap(bitmap,resolution)
#_cdCreateCanvas_IMAGERGB_empty(width,height,has_alpha,resolution)    
    warn "DEBUG $ch ",$ch->cnvhandle,"\n";
  }
  return $ch;
}

1;
