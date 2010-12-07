#!/usr/bin/env perl

package IUP::Canvas;
use strict;
use warnings;
use base qw(IUP::Internal::Element IUP::Internal::Canvas);
use IUP::Internal::LibraryIup;

sub _special_initial_map_cb {
  my $self = shift;
  if (!$self->cnvhandle) {
    warn "Mapping...!\n";
    #my $ch = IUP::Internal::LibraryIup::_cdCreateCanvas_CD_IUP($self->ihandle);  
    my $ch = IUP::Internal::Canvas::_cdCreateCanvas_CD_IUP($self->ihandle);  
    $self->cnvhandle($ch);
  }
  else {
    warn "Nothing!\n";
    # xxx TODO xxx perhaps deactivate callback here
  }
}

sub _create_element {
  my($self, $args) = @_;
  my $ih = IUP::Internal::LibraryIup::_IupCanvas(0); #xxx TODO fix '0'
  $self->ihandle($ih);
  my $f = \&_special_initial_map_cb;
  $self->MAP_CB($f);
  return $ih;
}

#Note: all canvas related methods are inherited from IUP::Internal::Canvas

# CONSTANTS:

#query value
###CD_QUERY => -1;

# bitmap type - these definitions are compatible with the IM library
###CD_RGB  => 0;
###CD_MAP  => 1;
###CD_RGBA => 0x100;

# bitmap data
###CD_IRED   => 0;
###CD_IGREEN => 1;
###CD_IBLUE  => 2;
###CD_IALPHA => 3;
###CD_INDEX  => 4; 
###CD_COLORS => 5;

# status report
###CD_ERROR => -1;
###CD_OK    =>  0;

# clip mode
###CD_CLIPOFF     => 0;
###CD_CLIPAREA    => 1;
###CD_CLIPPOLYGON => 2;
###CD_CLIPREGION  => 3;

# region combine mode
###CD_UNION        => 0;
###CD_INTERSECT    => 1;
###CD_DIFFERENCE   => 2;
###CD_NOTINTERSECT => 3;

# polygon mode (begin...end)
###CD_FILL         => 0;
###CD_OPEN_LINES   => 1;
###CD_CLOSED_LINES => 2;
###CD_CLIP         => 3
###CD_BEZIER       => 4;
###CD_REGION       => 5;
###CD_PATH         => 6;
###CD_POLYCUSTOM   => 10;

# path actions
###CD_PATH_NEW        => 0;
###CD_PATH_MOVETO     => 1;
###CD_PATH_LINETO     => 2;
###CD_PATH_ARC        => 3;
###CD_PATH_CURVETO    => 4;
###CD_PATH_CLOSE      => 5;
###CD_PATH_FILL       => 6;
###CD_PATH_STROKE     => 7;
###CD_PATH_FILLSTROKE => 8;
###CD_PATH_CLIP       => 9;

# fill mode
###CD_EVENODD => 0;
###CD_WINDING => 1;

# line join 
###CD_MITER => 0;
###CD_BEVEL => 1;
###CD_ROUND => 2;

# line cap 
###CD_CAPFLAT   => 0;
###CD_CAPSQUARE => 1;
###CD_CAPROUND  => 2;

# background opacity mode
###CD_OPAQUE      => 0;
###CD_TRANSPARENT => 1;

# write mode
###CD_REPLACE => 0;
###CD_XOR     => 1;
###CD_NOT_XOR => 2;

# color allocation mode (palette)
###CD_POLITE => 0;
###CD_FORCE  => 1;

# line style
###CD_CONTINUOUS => 0;
###CD_DASHED     => 1;
###CD_DOTTED     => 2;
###CD_DASH_DOT   => 3;
###CD_DASH_DOT_DOT => 4;
###CD_CUSTOM     => 5;

# marker type
###CD_PLUS           => 0;
###CD_STAR           => 1;
###CD_CIRCLE         => 2;
###CD_X              => 3;
###CD_BOX            => 4;
###CD_DIAMOND        => 5;
###CD_HOLLOW_CIRCLE  => 6;
###CD_HOLLOW_BOX     => 7;
###CD_HOLLOW_DIAMOND => 8;

# hatch type
###CD_HORIZONTAL => 0;
###CD_VERTICAL   => 1;
###CD_FDIAGONAL  => 2;
###CD_BDIAGONAL  => 3;
###CD_CROSS      => 4;
###CD_DIAGCROSS  => 5;

# interior style
###CD_SOLID   => 0;
###CD_HATCH   => 1;
###CD_STIPPLE => 2;
###CD_PATTERN => 3;
###CD_HOLLOW  => 4;

# text alignment
###CD_NORTH       => 0;
###CD_SOUTH       => 1;
###CD_EAST        => 2;
###CD_WEST        => 3;
###CD_NORTH_EAST  => 4;
###CD_NORTH_WEST  => 5;
###CD_SOUTH_EAST  => 6;
###CD_SOUTH_WEST  => 7;
###CD_CENTER      => 8;
###CD_BASE_LEFT   => 9;
###CD_BASE_CENTER => 10;
###CD_BASE_RIGHT  => 11;

# style
###CD_PLAIN     => 0;
###CD_BOLD      => 1;
###CD_ITALIC    => 2;
###CD_UNDERLINE => 4;
###CD_STRIKEOUT => 8;
###CD_BOLD_ITALIC => (CD_BOLD|CD_ITALIC);  # compatibility name

# some font sizes
###CD_SMALL    =>  8;
###CD_STANDARD => 12;
###CD_LARGE    => 18;

# Canvas Capabilities
###CD_CAP_NONE             => 0x00000000;
###CD_CAP_FLUSH            => 0x00000001;
###CD_CAP_CLEAR            => 0x00000002;
###CD_CAP_PLAY             => 0x00000004;
###CD_CAP_YAXIS            => 0x00000008;
###CD_CAP_CLIPAREA         => 0x00000010;
###CD_CAP_CLIPPOLY         => 0x00000020;
###CD_CAP_REGION           => 0x00000040;
###CD_CAP_RECT             => 0x00000080;
###CD_CAP_CHORD            => 0x00000100;
###CD_CAP_IMAGERGB         => 0x00000200;
###CD_CAP_IMAGERGBA        => 0x00000400;
###CD_CAP_IMAGEMAP         => 0x00000800;
###CD_CAP_GETIMAGERGB      => 0x00001000;
###CD_CAP_IMAGESRV         => 0x00002000;
###CD_CAP_BACKGROUND       => 0x00004000;
###CD_CAP_BACKOPACITY      => 0x00008000;
###CD_CAP_WRITEMODE        => 0x00010000;
###CD_CAP_LINESTYLE        => 0x00020000;
###CD_CAP_LINEWITH         => 0x00040000;
###CD_CAP_FPRIMTIVES       => 0x00080000;
###CD_CAP_HATCH            => 0x00100000;
###CD_CAP_STIPPLE          => 0x00200000;
###CD_CAP_PATTERN          => 0x00400000;
###CD_CAP_FONT             => 0x00800000;
###CD_CAP_FONTDIM          => 0x01000000;
###CD_CAP_TEXTSIZE         => 0x02000000;
###CD_CAP_TEXTORIENTATION  => 0x04000000;
###CD_CAP_PALETTE          => 0x08000000;
###CD_CAP_LINECAP          => 0x10000000;
###CD_CAP_LINEJOIN         => 0x20000000;
###CD_CAP_PATH             => 0x40000000;
###CD_CAP_BEZIER           => 0x80000000;
###CD_CAP_ALL              => 0xFFFFFFFF;

# cdPlay definitions
###CD_ABORT    => 1;
###CD_CONTINUE => 0;

# simulation flags
###CD_SIM_NONE         => 0x0000;
###CD_SIM_LINE         => 0x0001;
###CD_SIM_RECT         => 0x0002;
###CD_SIM_BOX          => 0x0004;
###CD_SIM_ARC          => 0x0008;
###CD_SIM_SECTOR       => 0x0010;
###CD_SIM_CHORD        => 0x0020;
###CD_SIM_POLYLINE     => 0x0040;
###CD_SIM_POLYGON      => 0x0080;
###CD_SIM_TEXT         => 0x0100;
###CD_SIM_ALL          => 0xFFFF;
###CD_SIM_LINES => (CD_SIM_LINE | CD_SIM_RECT | CD_SIM_ARC | CD_SIM_POLYLINE);
###CD_SIM_FILLS => (CD_SIM_BOX | CD_SIM_SECTOR | CD_SIM_CHORD | CD_SIM_POLYGON);

# some predefined colors for convenience
###CD_RED           => 0xFF0000L;   # 255,  0,  0
###CD_DARK_RED      => 0x800000L;   # 128,  0,  0
###CD_GREEN         => 0x00FF00L;   #   0,255,  0
###CD_DARK_GREEN    => 0x008000L;   #   0,128,  0
###CD_BLUE          => 0x0000FFL;   #   0,  0,255
###CD_DARK_BLUE     => 0x000080L;   #   0,  0,128
###CD_YELLOW        => 0xFFFF00L;   # 255,255,  0
###CD_DARK_YELLOW   => 0x808000L;   # 128,128,  0
###CD_MAGENTA       => 0xFF00FFL;   # 255,  0,255
###CD_DARK_MAGENTA  => 0x800080L;   # 128,  0,128
###CD_CYAN          => 0x00FFFFL;   #   0,255,255
###CD_DARK_CYAN     => 0x008080L;   #   0,128,128
###CD_WHITE         => 0xFFFFFFL;   # 255,255,255
###CD_BLACK         => 0x000000L;   #   0,  0,  0
###CD_DARK_GRAY     => 0x808080L;   # 128,128,128
###CD_GRAY          => 0xC0C0C0L;   # 192,192,192

# some usefull conversion factors
###CD_MM2PT   =>  2.834645669   # milimeters to points (pt = CD_MM2PT * mm)
###CD_RAD2DEG => 57.295779513   # radians to degrees (deg = CD_RAD2DEG * rad)
###CD_DEG2RAD => 0.01745329252  # degrees to radians (rad = CD_DEG2RAD * deg)

# paper sizes
###CD_A0     => 0;
###CD_A1     => 1;
###CD_A2     => 2;
###CD_A3     => 3;
###CD_A4     => 4;
###CD_A5     => 5; 
###CD_LETTER => 6;
###CD_LEGAL  => 7;

1;
