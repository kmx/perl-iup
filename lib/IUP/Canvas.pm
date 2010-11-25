#!/usr/bin/env perl

package IUP::Canvas;
use strict;
use warnings;
use base 'IUP::Internal::Element';
use IUP::Internal::LibraryIup;
#use IUP::Internal::LibraryCD;

sub _special_initial_map_cb {
  my $self = shift;
  if (!$self->cnvhandle) {
    warn "Mapping...!\n";
    my $ch = IUP::Internal::LibraryIup::_cdCreateCanvas_CD_IUP($self->ihandle);  
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

sub cdCanvasLine {
  my($self, $x1, $y1, $x2, $y2) = @_;
  return IUP::Internal::LibraryIup::_cdCanvasLine($self->cnvhandle, $x1, $y1, $x2, $y2);
}

sub Box {
  my($self, $x1, $y1, $x2, $y2) = @_;
  #return IUP::Internal::LibraryCD::_cdCanvasBox($self->cvnhandle, $x1, $x2, $y1, $y2);
}

#cdCanvasBegin(canvas, CD_PATH);
#cdCanvasPathSet(canvas, CD_PATH_MOVETO);
#cdCanvasVertex(canvas, x1, y1);
#cdCanvasEnd(canvas);

#void cdCanvasText(cdCanvas* canvas, int x, int y, const char* text); [in C]
#void cdCanvasFont(cdCanvas* canvas, const char* typeface, int style, int size); [in C]

#void cdCanvasLine(cdCanvas* canvas, int x1, int y1, int x2, int y2); [in C]
#void cdCanvasRect(cdCanvas* canvas, int xmin, int xmax, int ymin, int ymax); [in C]
#void cdCanvasArc(cdCanvas* canvas, int xc, int yc, int w, int h, double angle1, double angle2); [in C]
#int cdCanvasLineStyle(cdCanvas* canvas, int style); [in C]
#void cdCanvasLineStyleDashes(cdCanvas* canvas, const int* dashes, int count); [in C]
#int cdCanvasLineWidth(cdCanvas* canvas, int width); [in C]
#int cdCanvasLineJoin(cdCanvas* canvas, int style); [in C]
#int cdCanvasLineCap(cdCanvas* canvas, int style); [in C]

1;
