package IUP::Canvas::FileVector;
use strict;
use warnings;
use base qw(IUP::Internal::Canvas);
use IUP::Internal::LibraryIup;
use Carp;

#### supported formats:

###PS - http://www.tecgraf.puc-rio.br/cd/en/drv/ps.html
# "filename -p[paper] -w[width] -h[height] -l[left] -r[right] -b[bottom] -t[top] -s[resolution] [-e] [-g] [-o] [-1] d[margin]"
# "%s -p%d -w%g -h%g -l%g -r%g -b%g -t%g -s%d -e -o -1 -g -d%g"

###SVG - http://www.tecgraf.puc-rio.br/cd/en/drv/svg.html
# "filename [widthxheight] [resolution]"
# "%s %gx%g %g"

###CGM - http://www.tecgraf.puc-rio.br/cd/en/drv/cgm.html
# "filename [widthxheight] [resolution] [-t] -p[precision]"
# "%s %gx%g %g %s"

###DEBUG - http://www.tecgraf.puc-rio.br/cd/en/drv/debug.html
# "filename [widthxheight] [resolution]"
# "%s %gx%g %g"

###DGN - http://www.tecgraf.puc-rio.br/cd/en/drv/dgn.html 
# "filename [widthxheight] [resolution] [-f] [-sseedfile]"
# "%s %gx%g %g %s"

###DXF - http://www.tecgraf.puc-rio.br/cd/en/drv/dxf.html 
# "filename [widthxheight] [resolution]"
# "%s %gx%g %g"

###EMF - http://www.tecgraf.puc-rio.br/cd/en/drv/emf.html 
# "filename widthxheight"
# "%s %dx%d"

###METAFILE - http://www.tecgraf.puc-rio.br/cd/en/drv/mf.html 
# "filename [widthxheight resolution]"
# "%s %gx%g %g"

###WMF - http://www.tecgraf.puc-rio.br/cd/en/drv/wmf.html 
# "filename widthxheight [resolution]" 
# "%s %dx%d %g"

#XXX-FIXME IUP::Canvas::FileVector DOES NOT WORK AT ALL!!!

sub new {
  my ($self, %args) = @_;
  my $format = $args{format};
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
    $ch = $self->new_from_cnvhandle(IUP::Internal::Canvas::_cdCreateCanvas_BASIC($format, $init));
  }
  return $ch;
}

1;
